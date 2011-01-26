require 'spec_helper'

describe 'Feature: User authentication' do
  let(:user) { Factory :user }

  context 'Given valid credentials' do
    it 'I can log in' do
      visit new_user_session_path
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'

      page.should have_content("Signed in successfully.")
      page.should have_content("Hello #{user.name}")
    end
  end

  context 'Given invalid credentials' do
    it 'I can not log in' do
      visit new_user_session_path
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => 'invalid'
      click_button 'Sign in'

      page.should have_content('Invalid email or password.')
    end
  end

  context 'Given I am logged out' do
    context 'When I go to my dashboard' do
      before do
        visit new_user_session_path
      end

      it 'I am required to log in first' do
        page.should have_content('Sign in')
      end
    end
  end

  context 'When I have failed to log in 5 consecutive times' do
    before do
      visit new_user_session_path
      5.times do
        fill_in 'Email', :with => user.email
        fill_in 'Password', :with => 'invalid'
        click_button 'Sign in'
      end
    end

    it 'Then it says my account has been locked' do
      page.should have_content("Your account is locked.")
    end

    it 'Then I am not able to login with valid credentials' do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
      page.should have_content("Your account is locked.")
    end

    context 'But after an hour' do
      before do
        Timecop.travel 1.hour.from_now
      end

      it 'Then I am able to log in with valid credentials' do
        fill_in 'Email', :with => user.email
        fill_in 'Password', :with => user.password
        click_button 'Sign in'

        page.should have_content("Signed in successfully.")
        page.should have_content("Hello #{user.name}")
      end

      after do
        Timecop.return
      end
    end
  end

end

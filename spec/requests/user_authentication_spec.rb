require 'spec_helper'

describe 'Feature: User authentication' do
  let(:user) { Factory :user }

  shared_examples_for 'successful login' do
    specify do
      page.should have_css('p[class=notice]', :content => 'Signed in successfully.')
      page.should have_content("Hello #{user.name}")
      page.should have_css("a[href='#{destroy_user_session_path}']", :content => 'Logout')
    end
  end

  context 'Given I am not logged in' do
    context 'When I go to my dashboard' do
      before do
        visit new_user_session_path
      end

      it 'requires a log in' do
        page.should have_content('Email')
        page.should have_content('Password')
        page.should have_content('Sign in')
      end
    end
  end

  context 'Given valid credentials' do
    before do
      visit new_user_session_path
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Sign in'
    end

    it_should_behave_like 'successful login'

    context 'With 1 hour of inactivity' do
      before do
        Timecop.travel 1.hour.from_now
        visit root_path
      end

      it 'logs me out' do
        page.should have_css('p[class=alert]', :content => 'Your session expired, please sign in again to continue.')
        page.should have_content('Sign in')
      end

      after do
        Timecop.return
      end
    end
  end

  context 'Given invalid credentials' do
    it 'I can not log in' do
      visit new_user_session_path
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => 'invalid'
      click_button 'Sign in'

      page.should have_css('p[class=alert]', :content => 'Invalid email or password.')
    end

    context 'When I fail to log in 5 times' do
      before do
        visit new_user_session_path
        5.times do
          fill_in 'Email', :with => user.email
          fill_in 'Password', :with => 'invalid'
          click_button 'Sign in'
        end
      end

      it 'locks my account' do
        page.should have_css('p[class=alert]', :content => 'Your account is locked.')
      end

      it 'fails to log in with valid credentials' do
        fill_in 'Email', :with => user.email
        fill_in 'Password', :with => user.password
        click_button 'Sign in'
        page.should have_css('p[class=alert]', :content => 'Your account is locked.')
      end

      context 'But after an hour with valid credentials' do
        before do
          Timecop.travel 1.hour.from_now
          fill_in 'Email', :with => user.email
          fill_in 'Password', :with => user.password
          click_button 'Sign in'
        end

        it_should_behave_like 'successful login'

        after do
          Timecop.return
        end
      end
    end
  end
end

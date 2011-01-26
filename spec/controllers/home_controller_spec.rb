require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    context "when not logged in" do
      it "redirects to sign in" do
        get :index
        response.should redirect_to new_user_session_path
      end
    end

    context "when logged in" do
      let(:user) { Factory :user }

      before do
        sign_in user
        get :index
      end

      it "renders the index page" do
        response.should be_success
        response.should render_template :index
      end
    end
  end

end

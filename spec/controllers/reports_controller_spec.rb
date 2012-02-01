require 'spec_helper'

describe ReportController do

  describe "GET 'new'" do
    it "renders the new page" do
      response.should be_success
      response.should render_template :new
    end
  end

  describe "POST 'index'" do
    it "creates a report"
  end

end

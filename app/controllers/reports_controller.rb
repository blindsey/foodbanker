class ReportsController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
    @report = Report.new
  end

  def index
  end

end

require 'spec_helper'

describe Report do
  context "validations" do
    before do
      @valid_attributes = {
        :year => '2012', :quarter => '1', :region => 'lompoc',
        :agency_name => 'Agency', :program_name => 'Program',
        :person_name => 'Person', :phone_number => '415-867-5309'
      }
      @valid_report = Report.new(@valid_attributes)
    end

    it "is valid" do
      @valid_report.should be_valid
    end

    it "validates year" do
      @valid_report.year = '199a'
      @valid_report.should_not be_valid
      @valid_report.errors[:year].should be
    end

    it "validates phone number" do
      @valid_report.phone_number = '4158675309'
      @valid_report.should_not be_valid
      @valid_report.errors[:phone_number].should be
    end

    it "validates quarter" do
      @valid_report.quarter = '5'
      @valid_report.should_not be_valid
      @valid_report.errors[:quarter].should be
    end

    it "validates region" do
      @valid_report.region = 'west'
      @valid_report.should_not be_valid
      @valid_report.errors[:region].should be
    end

    [:year, :quarter, :region, :agency_name, :program_name, :person_name, :phone_number].each do |key|
      it "validates that #{key} is required" do
        report = Report.new(@valid_attributes)
        report[key] = nil
        report.should_not be_valid
        report.errors[key].should be
      end
    end

    [:agency_name, :program_name, :person_name].each do |key|
      it "validates that #{key} is at least 4 characters" do
        report = Report.new(@valid_attributes)
        report[key] = 'aaa'
        report.should_not be_valid
        report.errors[key].should be
      end
    end

    it "validates that new_clients is the sum of ages" do
      @valid_report.new_clients = 2
      @valid_report.age_18_59 = 1
      @valid_report.should_not be_valid
      @valid_report.errors[:new_clients].should be
    end

    it "validates that new_clients is the sum of genders" do
      @valid_report.new_clients = 2
      @valid_report.gender_male = 1
      @valid_report.should_not be_valid
      @valid_report.errors[:new_clients].should be
    end
  end
end

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    year "2000"
    quarter "1"
    region "south"
    agency_name "MyString"
    program_name "MyString"
    person_name "MyString"
    phone_number "MyString"
  end
end

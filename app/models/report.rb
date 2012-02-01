class Report < ActiveRecord::Base
  QUARTERS = %w(1 2 3 4)
  REGIONS = %w(north south lompoc)

  validates :year, :presence => true, :format => { :with => /\A\d{4}\Z/, :message => "%{value} is not a valid year" }
  validates :quarter, :presence => true, :inclusion => { :in => QUARTERS, :message => "%{value} is not a valid quarter" }
  validates :region, :presence => true, :inclusion => { :in => REGIONS, :message => "%{value} is not a valid region" }

  validates :agency_name, :presence => true, :length => { :minimum => 4 }
  validates :program_name, :presence => true, :length => { :minimum => 4 }
  validates :person_name, :presence => true, :length => { :minimum => 4 }
  validates :phone_number, :presence => true, :format => { :with => /\A\d{3}-\d{3}-\d{4}\Z/, :message => "%{value} is not a valid phone number" }

  validate :new_clients_is_sum_of_ages, :new_clients_is_sum_of_genders

  def new_clients_is_sum_of_ages
    if (age_0_17 + age_18_59 + age_60_plus) != new_clients
      errors.add(:new_clients, "must be the sum of all the age groups")
    end
  end

  def new_clients_is_sum_of_genders
    if (gender_male + gender_female) != new_clients
      errors.add(:new_clients, "must be the sum of the genders")
    end
  end
end

class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :year, :null => false, :length => 4
      t.string :quarter, :null => false, :length => 1
      t.string :region, :null => false, :length => 6

      t.string :agency_name, :null => false
      t.string :program_name, :null => false
      t.string :person_name, :null => false
      t.string :phone_number, :null => false, :length => 12

      t.integer :new_clients, :null => false, :default => 0
 
      t.integer :age_0_17, :null => false, :default => 0
      t.integer :age_18_59, :null => false, :default => 0
      t.integer :age_60_plus, :null => false, :default => 0

      t.integer :gender_male, :null => false, :default => 0
      t.integer :gender_female, :null => false, :default => 0

      t.integer :homeless_individuals, :null => false, :default => 0
      t.integer :homeless_families, :null => false, :default => 0
      t.integer :homeless_chronic, :null => false, :default => 0
      t.integer :female_head_of_household, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end

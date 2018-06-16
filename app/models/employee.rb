class Employee < ActiveRecord::Base
    validates :name, :color, presence: true
end

class Attendee < ApplicationRecord
	has_many :registrations
	has_many :workshops, :through=>:registrations
end

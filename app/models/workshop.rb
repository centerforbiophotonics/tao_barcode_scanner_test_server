class Workshop < ApplicationRecord
	has_many :registrations
	has_many :attendees, :through=>:registrations
end

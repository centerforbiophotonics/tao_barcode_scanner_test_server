module LoadAttendeeData

	def self.included(base)
		base.extend(self)
	end

	def load_csv(filepath, workshop_name)
		require 'csv'
		CSV.foreach(filepath, :headers => true) do |row|
			#Create new attendee
			a = Attendee.new
			a.name = row[0] + " " + row["First Name"]
			a.kerberos = row['Kerberos ID']
			a.save!

			#Register new attendee
		 	r = Registration.new
			r.attended = false;
			r.attendee_id = a.id
			if Workshop.exists?(:name => workshop_name)
				w = Workshop.find_by(:name => workshop_name)
				r.workshop_id = w.id
			else
				w = Workshop.new(:name => workshop_name)
				w.save!
				r.workshop_id = w.id
			end
			r.save!

			puts "Name: #{a.name}, ID: #{a.kerberos} saved and registered for"
			puts "workshop ##{r.workshop_id}"
		end	  
	end

	def reverse
		require 'csv'
		csv_data = File.read(Rails.root.join('lib', 'attendee_data.csv'))
		csv = CSV.parse(csv_data, :headers => true)
		csv.each do |row|
			a = Attendee.find_by(:kerberos => row["Kerberos ID"])
			r = Registration.find_by(:attendee_id => a.id)
			if r
				if Workshop.exists?(:id => r.workshop_id)
					Workshop.find_by(:id => r.workshop_id).destroy
				end
			end
			if a 
				if Registration.exists?(:attendee_id => a.id)
					Registration.find_by(:attendee_id => a.id).destroy
				end
			end
			Attendee.find_by(:kerberos => row["Kerberos ID"]).destroy		
		end
	end
end
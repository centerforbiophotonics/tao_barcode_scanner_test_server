namespace :stress_test do
	desc "This task will generate a pre-determined amount of attendees,
	and register them for a pre-determined amount of workshops for the
	purpose of stress testing the application."
	task generate: :environment do
		DESIRED_WORKSHOPS = 64
		DESIRED_ATTENDEES = 10000

		wc = Workshop.count
		ac = Attendee.count

		while (wc < DESIRED_WORKSHOPS)
			w = Workshop.new
			w.name = rand(36**10).to_s(36)
			w.save!
			wc += 1
		end

		while (ac < DESIRED_ATTENDEES)
			#Create new attendee
			a = Attendee.new
			a.name = rand(36**15).to_s(36)
			a.kerberos = rand(36**20).to_s(36)
			a.save!

			#Register new attendee
		 	r = Registration.new
			r.attended = false
			r.attendee_id = a.id
			w = Workshop.order("RANDOM()").first
			r.workshop_id = w.id
			r.save!

			puts "Name: #{a.name}, ID: #{a.kerberos} saved and registered for"
			puts "workshop ##{r.workshop_id}"
			ac += 1
		end
	end
end
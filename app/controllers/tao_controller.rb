class TaoController < ApplicationController
  def workshops
   #render :json => File.read(Rails.root.join("app/views/tao/dummy.json"))
	  @workshops = []
	  Workshop.all.each do |w|
	  	workshop = {:id => w.id, :name => w.name, :registrants => []}
	  	w.registrations.each do |r|
	  		a = r.attendee
	  		workshop[:registrants].push({:id => a.kerberos, :name => a.name, :attended => r.attended})
	  	end
	  	@workshops.push(workshop)
	  end
	  number = rand(10)
	  if (number <= 4 && number >= 0)
	  	render json: @resource, status: 500
	  else
	  	render :json => @workshops
	  end
  end

  def attend
    # render :json => {status: "fail"}
    a = Attendee.where(:kerberos => params[:attendee_id]).first
    r = Registration.where(:attendee_id => a.id, :workshop_id => params[:workshop_id]).first
    r.attended = true;
    number = rand(10)
    puts number
    if number <= 8 && number >= 0
	    if r.save
	    	render :json => {status: "success"}
	    else
	    	render :json => {status: "failure"}
	    end
	else
		 render json: @resource, status: 500
	end
  end
end

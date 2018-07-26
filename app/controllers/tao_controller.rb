class TaoController < ApplicationController
  WORKSHOP_ERR_CHANCE = 4
  ATTEND_ERR_CHANCE = 2
  def workshops
	  @workshops = []
	  Workshop.all.each do |w|
	  	workshop = {:id => w.id, :name => w.name, :registrants => []}
	  	w.registrations.each do |r|
	  		a = r.attendee
	  		workshop[:registrants].push({:id => a.kerberos, :name => a.name, :attended => r.attended})
	  	end
	  	@workshops.push(workshop)
	  end
	  ENV["ERROR_SIM"] == "true" ? number = rand(10) : number = 10
	  if (number <= WORKSHOP_ERR_CHANCE && number >= 0)
	  	render json: @resource, status: 500
	  else
	  	render :json => @workshops
	  end
  end

  def attend
    a = Attendee.where(:kerberos => params[:attendee_id]).first
    r = Registration.where(:attendee_id => a.id, :workshop_id => params[:workshop_id]).first
    r.attended = true;
    ENV["ERROR_SIM"] == "true" ? number = rand(10) : number = 10
    if number <= ATTEND_ERR_CHANCE && number >= 0
    	render json: @resource, status: 500
 	else
 		if r.save
 	    	render :json => {status: "success"}
 	    else
	    	render :json => {status: "failure"}
 	    end
 	end
  end
end

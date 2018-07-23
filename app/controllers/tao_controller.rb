class TaoController < ApplicationController
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
	  render :json => @workshops
  end

  def attend
    a = Attendee.where(:kerberos => params[:attendee_id]).first
    r = Registration.where(:attendee_id => a.id, :workshop_id => params[:workshop_id]).first
    r.attended = true;
    number = rand(10)
    puts number
    if r.save
    	render :json => {status: "success"}
    else
    	render :json => {status: "failure"}
    end
  end
end

class TaoController < ApplicationController
  def workshops
   #render :json => File.read(Rails.root.join("app/views/tao/dummy.json"))
	  @workshops = []
	  Workshop.all.each do |w|
	  	workshop = {:id => w.id, :name => w.name, :registrants => []}
	  	w.registrations.each do |r|
	  		a = r.attendee
	  		workshop[:registrants].push({:id => a.id, :name => a.name, :attended => r.attended})
	  	end
	  	@workshops.push(workshop)
	  end
	  render :json => @workshops
  end

  def attend
    # render :json => {status: "fail"}
    r = Registration.where(:attendee_id => params[:attendee_id], :workshop_id => params[:workshop_id]).first
    r.attended = true;
    if r.save
    	render :json => {status: "success"}
    else
    	render :json => {status: "failure"}
    end
  end
end

class IncidentsController < ApplicationController
  def index
    @incidents = Incident.all
    @new_incident = Incident.new
  end

  def explain
    @incident = Incident.find params[:id]
  end

  def create
    if params[:new_incident].blank? or params[:new_incident][:name].blank?

    end
    incident = Incident.new params[:incident]
    if incident.save
      flash[:notice] = "Incident description has been saved"
    else
      flash[:error] = "Could not save incident description"
    end
    redirect_to :action => "index"
  end
end

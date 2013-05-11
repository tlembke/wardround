
class VisitsController < ApplicationController
  # GET /visits
  # GET /visits.json
  def index
    @visits = Visit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @visits }
    end
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
    @visit = Visit.find(params[:id])




    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @visit }
    end
  end

  # GET /visits/new
  # GET /visits/new.json
  def new

    @visit = Visit.new

    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @visit }
      format.js
    end
  end

  # GET /visits/1/edit
  def edit
    @visit = Visit.find(params[:id])
  end

  # POST /visits
  # POST /visits.json
  def create
    # this is called from Ajax

    @visit = Visit.new
    @patient=Patient.find(params[:patient_id])
    @claim=Claim.find(params[:claim_id])
    @visit.patient_id=@patient.id
    @visit.date=Date.today
    @visit.claim_id=@claim.id
    @visit.duration=@claim.hospital.duration
    @visit.item=@claim.hospital.item
    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, :notice => 'Visit was successfully created.' }
        format.json { render :json => @visit, :status => :created, :location => @visit }
        format.js {render :nothing => true}
      else
        format.html { render :action => "new" }
        format.json { render :json => @visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /visits/1
  # PUT /visits/1.json
  def update
    @visit = Visit.find(params[:id])

    respond_to do |format|
      if @visit.update_attributes(params[:visit])
        format.html { redirect_to @visit, :notice => 'Visit was successfully updated.' }
        format.json { respond_with_bip(@visit) }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @visit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to visits_url }
      format.json { head :no_content }
    end
  end
  

  def remove
    @visit = Visit.where('patient_id=? and claim_id=?',params[:patient_id],params[:claim_id]).first
    debugger
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to visits_url }
      format.json { head :no_content }
      format.js {render :nothing => true}
    end
  end
end

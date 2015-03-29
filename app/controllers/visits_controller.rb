
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
      format.mobile {render :nothing => true}
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
    @round=Round.find(params[:round_id])
    @visit.doctor_id=current_user.id
    @visit.patient_id=@patient.id
    @visit.date=@round.date
    @visit.round_id=@round.id
    @visit.duration=@round.hospital.duration
    @visit.item=@round.hospital.item
    
    if @patient.charge == NIL or @patient.charge==0
      @visit.item='0'
    end
    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, :notice => 'Visit was successfully created.' }
        format.json { render :json => @visit, :status => :created, :location => @visit }
        format.js 
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
    @visit = Visit.where('patient_id=? and round_id=?',params[:patient_id],params[:round_id]).first
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to visits_url }
      format.json { head :no_content }
      format.js {render :nothing => true}
      format.mobile {render :nothing => true}
    end
  end
  
  def charge
    @visit = Visit.where('patient_id=? and round_id=?',params[:patient_id],params[:round_id]).first
    item=1;
    if params[:item]
        item=params[:item]
    end
    if @visit
      @visit.item=item

      @visit.update_attribute(:item,@visit.item)
    else
        @visit = Visit.new
        @patient=Patient.find(params[:patient_id])
        @round=Round.find(params[:round_id])

        @visit.patient_id=@patient.id
        @visit.date=@round.date
        @visit.round_id=@round.id
        @visit.duration=@round.hospital.duration
        @visit.item=item
        @visit.save    
    end
    
    respond_to do |format|
      format.html
      format.js {render :nothing => true}
    end
  end
  def uncharge
    @visit = Visit.where('patient_id=? and round_id=?',params[:patient_id],params[:round_id]).first
    if @visit
      @visit.item="0"

      @visit.update_attribute(:item,@visit.item)
    end
    respond_to do |format|
      format.html
      format.js {render :nothing => true}
    end
  end
  private
      # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      params.require(:visit).permit(:date, :doctor_id, :duration, :item, :chargenote, :patient_id, :ward_id)
    end
end

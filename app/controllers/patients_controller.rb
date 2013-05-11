
class PatientsController < ApplicationController
  # default display
  # shows all current inpatients
  # GET /patients
  # GET /patients.json
  def index
    if params[:round_id] and params[:round_id]!='0'
      @round=Round.find(params[:round_id])
    else
        date=Date.today
        date=params[:date] if params[:date]
        order="DESC"
        order = params[:order] if params[:order]
        @round=Round.ondate(date,order)
    end
    @patients = Patient.inpatients(@round.date)
    #@patients=Patient.find(:all)
    @hospitals=Hospital.find(:all)
    @claims=Array.new
    @hospitals.each do |hospital|
      @claims[hospital.id]=Claim.find_or_create_by_round_id_and_hospital_id(:round_id=>@round.id,:hospital_id=> hospital.id)
    end
    @wards=Array.new
    @hospitals.each do |hospital|
      @wards[hospital.id]=Ward.where('hospital_id=?',hospital.id)
    end
   


    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.find(params[:id])
    if params[:round_id] and params[:round_id]!='0'
      @round=Round.find(params[:round_id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.json
  def new
    @patient = Patient.new
    @hospitals=Hospital.find(:all)
    hospital=@hospitals[0]
    @wards = Hospital.find(hospital.id).wards
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @patient }
    end
  end

  # GET /patients/1/edit
  def edit
    @hospitals=Hospital.find(:all)
    hospital=@hospitals[0]
    @wards = Hospital.find(hospital.id).wards
    @patient = Patient.find(params[:id])
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(params[:patient])

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, :notice => 'Patient was successfully created.' }
        format.json { render :json => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.json { render :json => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.json
  def update
    @patient = Patient.find(params[:id])
    params[:patient][:admission]=Date.strptime(params[:patient][:admission],'%d/%m/%y') if params[:patient][:admission]
    params[:patient][:discharge]=Date.strptime(params[:patient][:discharge],'%d/%m/%y') if params[:patient][:discharge]
    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to @patient, :notice => 'Patient was successfully updated.' }
        format.json { respond_with_bip(@patient) }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end
  
  def discharge
      date=Date.today
      source='patients/dischargepatient'
      if params[:claim_id].present?
        @claim=Claim.find(params[:claim_id])
        date=@claim.date
        source='patients/discharge'
      end
      @patient=Patient.update(params[:id],:discharge=>date)
      respond_to do |format|
        format.html
        format.js {render :template => source}
      end
  end
  
  def undischarge
    
      @patient=Patient.update(params[:id],:discharge=>'')
      respond_to do |format|
        format.html
        format.js {render :template => 'patients/undischarge.js'}
      end
  end
  def decrement
      @patient = Patient.find(params[:id])
      @patient.update_attribute(:discharge,@patient.discharge-1.day)
      respond_to do |format|
        format.html
        format.js
      end
  end
  
  def changeward
      @patient = Patient.find(params[:id])
      @patient.update_attribute(:ward_id,params[:ward_id])
      respond_to do |format|
        format.html
        format.js {render :nothing => true}
      end
      
  end
  
  def under
    @patient = Patient.find(params[:id])
    if @patient.under==0 or @patient.under==""
      @patient.under=1
    else
      @patient.under=0
    end
    @patient.update_attribute(:under,@patient.under)
    respond_to do |format|
      format.html
      format.js {render :nothing => true}
    end
  end

end

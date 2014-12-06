class HospitalsController < ApplicationController




  # GET /hospitals
  # GET /hospitals.json
  
 

  def index
    @hospitals = Hospital.all

    # get date - use current month as default
    if params[:theDate]
      @theDate=Date.strptime(params[:theDate],'%d/%m/%y')
    else
      @theDate= Date.today
    end
    
    if params[:handover] and params[:handover]!="false"
      @period='day'
      @startDate=@theDate
      @endDate=@theDate
      @prevDate=@theDate-1.day
      @nextDate=@theDate+1.day
      @periodSpan=1
      @handover=true;
      
    else
      @handover=false;
    
      if request_device?(:iphone)
        @period='week'
        @device='iphone'
        @startDate=@theDate.at_beginning_of_week
        @endDate=@startDate.at_end_of_week
        @prevDate=@startDate-1.week
        @nextDate=@startDate+1.week
        @periodSpan=7
        
      elsif request_device?(:ipad)
        @period='fortnight'
        @device='ipad'
        @startDate=@theDate.at_beginning_of_week
        @endDate=(@startDate+1.week).at_end_of_week
        @prevDate=@startDate-2.weeks
        @nextDate=@startDate+2.weeks
        @periodSpan=14
      else
        @period='month'
        @startDate=@theDate.at_beginning_of_month
        @endDate=@theDate.at_end_of_month
        @prevDate=@theDate-1.month
        @nextDate=@theDate+1.month
        @periodSpan=@endDate.day
      end
    end

   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hospitals }
    end
  end

  # GET /hospitals/1
  # GET /hospitals/1.json
  def show
    @hospital = Hospital.find(params[:id])
    # get date - use current month as default
    if params[:theDate]
      @theDate=Date.strptime(params[:theDate],'%d/%m/%y')
    else
      @theDate= Date.today
    end

  
 
    # get patients who were in hospital during that month
  

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @hospital }
    end
  end

  # GET /hospitals/new
  # GET /hospitals/new.json
  def new
    @hospital = Hospital.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @hospital }
    end
  end

  # GET /hospitals/1/edit
  def edit
    @hospital = Hospital.find(params[:id])
  end

  # POST /hospitals
  # POST /hospitals.json
  def create
    @hospital = Hospital.new(params[:hospital])

    respond_to do |format|
      if @hospital.save
        # else need to create a default ward
        @ward=Ward.new(:name=>"--",:hospital_id=>@hospital.id)
        @ward.save
        format.html { redirect_to @hospital, :notice => 'Hospital was successfully created.' }
        format.json { render :json => @hospital, :status => :created, :location => @hospital }
      else
        format.html { render :action => "new" }
        format.json { render :json => @hospital.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hospitals/1
  # PUT /hospitals/1.json
  def update
    @hospital = Hospital.find(params[:id])

    respond_to do |format|
      if @hospital.update_attributes(params[:hospital])
        format.mobile { redirect_to @hospital, :notice => 'Hospital was successfully updated.' }
        format.html { redirect_to @hospital, :notice => 'Hospital was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @hospital.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hospitals/1
  # DELETE /hospitals/1.json
  def destroy
    @hospital = Hospital.find(params[:id])
    @hospital.destroy

    respond_to do |format|
      format.html { redirect_to hospitals_url }
      format.json { head :no_content }
    end
  end
  
  
  def wards_by_hospital
    @hospital=Hospital.find(params[:hospital_id])
    @name=@hospital.name
    if params[:hospital_id].present?
      @wards = Hospital.find(params[:hospital_id].to_i).wards
    else
      @wards = []
    end

    respond_to do |format|
      format.html 
      format.js
    end
  end
  
  def  report
    @hospital = Hospital.find(params[:id])
    # get date - use current month as default
    if params[:month]
      @month=params[:month]
    else
      @month= Date.today.month
    end
    if params[:year]
      @year = params[:year]
    else
      @year = Date.today.year
    end
  
    @theDate=Date.parse(@year.to_s+"-"+@month.to_s+"-01")
    # get patients who were in hospital during that month
    @patients=Patient.inHospitalThisMonth(params[:id],@month,@year)
  end
  
  def handover
    @hospitals = Hospital.all
      @theDate= Date.today



   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hospitals }
    end
  end
  
end

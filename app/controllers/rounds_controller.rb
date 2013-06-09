
class RoundsController < ApplicationController
  # GET /rounds
  # GET /rounds.json
  

  def index
    if params[:id] and params[:id]!='0'
      @round=Round.find(params[:id])
    elsif params[:round_id] and params[:round_id]!='0'
      @round=Round.find(params[:round_id])
    elsif Hospital.count==1 or params[:hospital_id]
        date=Date.today
        date=Date.strptime(params[:date],"%d/%m/%y") if params[:date]
        order="DESC"
        order = params[:order] if params[:order]
        @round=Round.ondate(date,order,params[:hospital_id])
    end
    if @round
        redirect_to :action => "show", :id => @round.id
        return
    end
    @hospitals=Hospital.all
    #@claims=Array.new
    #@hospitals.each do |hospital|
      #@claims[hospital.id]=Claim.find_or_create_by_round_id_and_hospital_id(:round_id=>@round.id,:hospital_id=> hospital.id)
    #end
    if request.xhr?
      request.format = "mobile"
    end
    respond_to do |format|
      format.html
      format.mobile
      format.json { render :json => @patients }
    end
    

   
    

  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    if params[:id] and params[:id]!='0'
      @round=Round.find(params[:id])
    elsif params[:round_id] and params[:round_id]!='0'
      @round=Round.find(params[:round_id])
    else
        date=Date.today
        date=Date.strptime(params[:date],"%d/%m/%y") if params[:date]
        order="DESC"
        order = params[:order] if params[:order]
        @round=Round.ondate(date,order)
    end
    @patients = @round.inpatients
    #@patients=Patient.find(:all)
    @hospitals=Hospital.find(:all)
    @wards=Array.new
    @hospitals.each do |hospital|
      @wards[hospital.id]=Ward.where('hospital_id=?',hospital.id)
    end
    @hospital=Hospital.all
    if request.xhr?
      request.format = "mobile"
    end

    respond_to do |format|

      format.html # index.html.erb
      format.mobile
      format.json { render :json => @patients }
    end
 

  end

  # GET /rounds/new
  # GET /rounds/new.json
  def new
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @round }
    end
  end

  # GET /rounds/1/edit
  def edit
    @round = Round.find(params[:id])
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(params[:round])

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, :notice => 'Round was successfully created.' }
        format.json { render :json => @round, :status => :created, :location => @round }
      else
        format.html { render :action => "new" }
        format.json { render :json => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rounds/1
  # PUT /rounds/1.json
  def update
    @round = Round.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to @round, :notice => 'Round was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to rounds_url }
      format.json { head :no_content }
    end
  end
  
  def return
     @round = Round.find(params[:id])
     @round = @round.return

     redirect_to :controller=>:rounds,:action=>:show,:id=>@round.id

  end
end

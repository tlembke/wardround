
class ReportsController < ApplicationController
  
  def index
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
      
      # get patients who were in hospital during that month
      @patients=Patient.inThisMonth(@month,@year)
      
  end
end

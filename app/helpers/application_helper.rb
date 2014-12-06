module ApplicationHelper

  def formatteddate(date)
    date.strftime("%d/%m/%y")
  end
  
  def initalformatdate(date)
    date=Date.today unless date
      month=date.strftime("%m")
      month=month.to_i
      month=month+2-3
      text="["+date.strftime("%Y")+","+month.to_s+","+date.strftime("%-d")+"]"
 end
  
 def monthAndYear(month,year)
    month=Date.today.month unless month 
    year=Date.today.month unless year
    return 
   
 end
 
end



class DriverDropsController < ApplicationController

  def index
   @driver_drops = DriverDrop.all
   data_table = GoogleVisualr::DataTable.new
   
   data_table.new_column('string', 'Branch' )
   data_table.new_column('number', 'x86 Failures')
   data_table.new_column('number', 'x64 Failures')
   
#binding.pry "<a href='/driver_drop/#{drop.id}/'>#{drop.branch.to_s}</a>"
   @driver_drops.each do |drop|
    data_table.add_rows([[drop.branch , 
                          rand + 1, 
                          Log.where(:driver_drop_id => drop.id, :passfail => "failed").count,
                          ]])

   end
   #formatter = GoogleVisualr::PatternFormat.new('<a href="driver_drop/{1}">{}</a>')



   option = { width: 700, height: 500,   
              vAxis: {title: 'Driver Branch', titleTextStyle: {color: 'green'}},
              hAxis: {title: 'Failures', titleTextStyle: {color: 'red'}}
            }


   @chart = GoogleVisualr::Interactive::BarChart.new(data_table, option)
   #@chart.add_listener('ready', "window.addBranchLink")
   @chart.add_listener('select', "window.selectHandler")
   #binding.pry

  end

  def new
   @driver_drop = DriverDrop.new
  end

  def create 
   @driver_drop = DriverDrop.new(params[:driver_drop])

   if @driver_drop.save
    flash[:success] = "The Driver Drop has been added."
    redirect_to root_url
   else
    flash[:error] = "The Driver Drop has not been Added."
    render :action => "new"
   end
  end

  def edit
    @driver_drop = DriverDrop.find(params[:id])
    flash[:info] = "This is a info flash message"
  end

  def update
    @driver_drop = DriverDrop.find(params[:id])

    if @driver_drop = @driver_drop.update_attributes(params[:driver_drop])
      flash[:success] = "Driver Drop was changed."
      redirect_to driver_drop_path
    else
      flash[:error] = "Driver Drop was not changed."
      render action: "edit"
    end
  end

  def show
    @driver_drop = DriverDrop.find(params[:id])
    @log = Log.where({:driver_drop_id => params[:id]})
    #binding.pry
  end
end

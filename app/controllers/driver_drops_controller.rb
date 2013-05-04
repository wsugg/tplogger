class DriverDropsController < ApplicationController

 def index
   @driver_drops = DriverDrop.all

   data_table = GoogleVisualr::DataTable.new
   
   data_table.new_column('string', 'Branch' )
    data_table.new_column('number', 'Bugs')
    data_table.new_column('number', 'Failures')

  data_table.add_rows([
   [@driver_drops[0].branch.to_s, 10, 4],
   [@driver_drops[1].branch.to_s, 7, 60],
   [@driver_drops[2].branch.to_s, 6, 112],
   [@driver_drops[3].branch.to_s, 1, 5]
  ])

  option = { width: 700, height: 500, title: 'Driver Drop Quality', color: 'green' }
  @chart = GoogleVisualr::Interactive::BarChart.new(data_table, option)
   #binding.pry

 end

 def new
   @driver_drop = DriverDrop.new
 end

 def create 
   @driver_drop = DriverDrop.new(params[:driver_drop])
  
   if @driver_drop.save
    flash[:notice] = "The Driver Drop has been added."
    redirect_to root_url
   else
    flash[:alert] = "The Driver Drop has not been Added."
    render :action => "new"
   end
 end

def edit
  @driver_drop = DriverDrop.find(params[:id])
  
  
  flash[:warning] = "This is a warning flash message"
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
end

end

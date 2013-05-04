class LogsController < ApplicationController

#binding.pry
  def new
    @driver_drop = DriverDrop.find(params[:driver_drop_id])
  	@log = Log.new
    @log.driver_drop_id = @driver_drop.id
  end

  def index
  	@logs = Log.all
  end

  def edit
  	flash[:warning] = "This is a warning flash message"
    binding.pry
  end

  def create
    @driver_drop = DriverDrop.find(params[:driver_drop_id])
    @log = Log.create(params[:log])
    @log.driver_drop_id = @driver_drop.id
  	@log[:passfail] = "na"
    
    if @log.save
      flash[:success] = "Testlog was successfully created."
      binding.pry
      redirect_to driver_drop_path(@driver_drop) 
    else
      render :new
    end
  end

  def show
    @log = Log.find(params[:id])
  end
end

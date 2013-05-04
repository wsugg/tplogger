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
  	binding.pry
  end

  def create
    @driver_drop = DriverDrop.find(params[:driver_drop_id])
    @log = Log.create(params[:log])
    @log.driver_drop_id = @driver_drop.id
  	@log[:passfail] = "na"
    if @log.save
     redirect_to root_url, notice: "Testlog was successfully created."
    else
      render :new
    end

  end

  def show
    @log = Log.find(params[:id])
  end
end

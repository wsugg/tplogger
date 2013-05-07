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
      redirect_to driver_drop_path(@driver_drop) 
      parse_log
    else
      render :new
    end
  end

  def show
    @log = Log.find(params[:id])
  end

  private 
  def parse_log
    require 'nokogiri'
    logfile = nil
    flash[:success] = "parse log function was called."
    logfile = Nokogiri::XML(File.open(@log.testlog.path))
    if logfile.xpath("//PFRollup").attribute("Failed").to_s != "0"
      @log.passfail = "failed"
      @log.save
    end
  end
end

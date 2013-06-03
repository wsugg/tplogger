class LogsController < ApplicationController
 before_filter :find_driver_drop, :only => [:new, :create, :edit, :update ]
 before_filter :find_all_drops, :only => [:new, :show, :index, :edit]

  def new
    @log = Log.new
    @log.driver_drop_id = @driver_drop.id
  end

  def index
  	@logs = Log.all
  end

  def edit
    @log = Log.find(params[:id])
  end

  def create
    @log = Log.create(params[:log])
    @log.driver_drop_id = @driver_drop.id
  	@log[:passfail] = "na"
    
    if @log.save
      flash[:success] = "#{@log.default_name} was saved."
      redirect_to driver_drop_path(@driver_drop) 
      parse_log(@log.testlog.path)
    else
      render :new
    end
  end

  def update
    @log  =Log.find(params[:id])
     if @log.update_attributes(params[:log])
      flash[:success] = "The Log Record was changed."
      redirect_to driver_drop_path(@log.driver_drop_id)
    else
      flash[:error] = "The Log Record was not changed."
      render action: "edit"
    end
  end

  def show
    flash[:success] = params
  end

protected
 def find_driver_drop
  @driver_drop = DriverDrop.find(params[:driver_drop_id])
 end 
 def find_all_drops
  @driver_drops = DriverDrop.all
 end 

private 
    def parse_log(logf)
      require 'nokogiri'
      logfile = nil
      logfile = Nokogiri::XML(File.open(@log.testlog.path))
      flash[:success] = "File: #{@log.default_name} was uploaded and processed."
      @log.platform = logfile.xpath("//Machine").attribute("Platform").to_s

      if logfile.xpath("//PFRollup").attribute("Failed").to_s != "0"
        @log.passfail = "failed"
        @log.cmdline = logfile.xpath("//TestCommandLine").attribute("UserText").to_s
        flash[:warning] = "Failures found in #{@log.default_name} and were processed."
      end
      @log.save
    end
end

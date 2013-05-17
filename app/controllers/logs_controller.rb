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
    @log = Log.new(params[:log])
    @log.driver_drop_id = @driver_drop.id
  	@log[:passfail] = "na"
    
    if @log.save
      flash[:success] = "#{@log.default_name} was saved."
      redirect_to driver_drop_path(@driver_drop) 
      parse_log
    else
      render :new
    end
  end

  def show
    binding.pry
    @log = Log.find(params[:id])
    binding.pry
    @log.each do  |l|
     if l.passfail == "failed" && l.platform == "x86"
        @x86_failed_logs += l 
     elsif l.passfail == "failed" && l.platform == "AMD64"
        @x64_failed_logs += l
     else
        @unknown_platform_logs += l
     end
     binding.pry
  end

private 
    def parse_log
      require 'nokogiri'
      logfile = nil
      logfile = Nokogiri::XML(File.open(@log.testlog.path))
      flash[:success] = "File: #{@log.default_name} was uploaded and processed."
      @log.platform = logfile.xpath("//Machine").attribute("Platform").to_s

      if logfile.xpath("//PFRollup").attribute("Failed").to_s != "0"
        @log.passfail = "failed"
        flash[:warning] = "Failures found in #{@log.default_name} and were processed."
      end
      @log.save
      binding.pry
    end
end

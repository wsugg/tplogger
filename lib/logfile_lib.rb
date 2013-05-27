module LogFileLib
 def parse_log(logf)
      require 'nokogiri'
      logfile = nil
      logfile = Nokogiri::XML(File.open(logf))
      flash[:success] = "File: #{@log.default_name} was uploaded and processed."
      @log.platform = logfile.xpath("//Machine").attribute("Platform").to_s

      if logfile.xpath("//PFRollup").attribute("Failed").to_s != "0"
        @log.passfail = "failed"
        @log.cmdline = logfile.xpath("//TestCommandLine").attribute("UserText").to_s
        flash[:warning] = "Failures found in #{@log.default_name} and were processed."
      end
      @log.save
      #binding.pry
  end
end
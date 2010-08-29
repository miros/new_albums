configure do
  log = File.new(File.dirname(__FILE__)  + "/log/sinatra.log", "a+")
  LOGGER = Logger.new(log)
end

helpers do
  def logger
    LOGGER
  end
end

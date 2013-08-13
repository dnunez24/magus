module ApiHelpers
  def v2_soap_creds
    credentials("v2_soap")
  end

  def soap_creds
    credentials("soap")
  end

  def xmlrpc_creds
    credentials("xmlrpc")
  end

  def rest_creds
    credentials("rest")
  end

  def credentials(api=nil)
    credentials = config["credentials"]
    api ? credentials[api] : credentials
  end

  def hostname
    config["hostname"]
  end

  private

  def config
    file = File.expand_path("../../../config.yml", __FILE__)
    @config ||= YAML.load_file(file)
  rescue Errno::ENOENT
    raise "#{file} is missing. Please create this file with valid config settings."
  end
end

RSpec.configure do |config|
  config.include ApiHelpers
end
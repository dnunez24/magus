module ApiHelpers
  def load_credentials(api)
    file = File.expand_path("../../../credentials.yml", __FILE__)
    credentials = YAML.load_file(file)
    return credentials[api]
  rescue Errno::ENOENT
    raise "#{file} is missing. Please create this file with valid API credentials."
  end
end

World(ApiHelpers)
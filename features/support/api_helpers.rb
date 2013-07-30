module ApiHelpers
  def load_credentials(api)
    file = File.expand_path("../../../credentials.yml", __FILE__)
    credentials = YAML.load_file(file)
    return credentials[api]
  end
end

World(ApiHelpers)
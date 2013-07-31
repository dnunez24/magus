require 'savon'

module SoapHelper
  def last_call
    @last_call ||= Savon.observers.last
  end

  def last_operation
    last_call.operation
  end

  def last_request
    last_call.request
  end
end

class SoapObserver
  attr_reader :operation, :message, :request

  def notify(operation_name, builder, globals, locals)
    @operation = operation_name
    @message = locals[:message]
    @request = builder.to_s
    nil
  end
end

RSpec.configure do |config|
  config.include SoapHelper, :soap
  config.around(:each, :soap) do |example|
    Savon.observers << SoapObserver.new
    example.run
    Savon.observers.clear
  end
end
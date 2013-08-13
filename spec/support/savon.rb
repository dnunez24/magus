require 'savon'

module SoapHelper
  class SoapObserver
    attr_reader :operation, :message, :request

    def observe
      Savon.observers << self
    end

    def clear
      Savon.observers.clear
    end

    def last_call
      @last_call ||= Savon.observers.last
    end

    def last_operation
      last_call.operation
    end

    def last_request
      last_call.request
    end

    def notify(operation_name, builder, globals, locals)
      @operation = operation_name
      @message = locals[:message]
      @request = builder.to_s
      nil
    end
  end

  def soap
    @soap ||= SoapObserver.new
  end
end

RSpec.configure do |config|
  config.include SoapHelper, :soap
  config.around(:each, :soap) do |example|
    soap.observe
    example.run
    soap.clear
  end
end

module Magus
  module SOAPv2
    require 'savon'

    class Client < Savon::Client
      attr_reader :session_id

      def login(username, api_key)
        response = self.call :login, message: {username: username, apiKey: api_key}
        @session_id = get_session_id_from_login_response(response)
        self
      rescue Savon::SOAPFault
        raise Magus::SOAPFault
      end

      def logout
        if @session_id
          self.call :end_session, message: {sessionId: @session_id}
          @session_id = nil
        end
        self
      end

    private

      def get_session_id_from_login_response(response)
        response.body[:login_response][:login_return]
      end
    end
  end
end
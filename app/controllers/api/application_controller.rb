module Api
  class ApplicationController < ::ApplicationController
    self.responder = ::ApplicationResponder
    skip_before_action :verify_authenticity_token
    respond_to :json
  end
end

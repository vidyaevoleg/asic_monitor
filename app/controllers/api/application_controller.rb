module Api
  class ApplicationController < ::ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :json
  end
end

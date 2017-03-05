class SessionsController < Clearance::SessionsController
  protected
    def url_after_create
      '/admin'
    end

    def url_after_destroy
      '/admin'
    end
end
class PasswordsController < Clearance::PasswordsController
  protected
    def url_after_create
      '/admin'
    end

    def url_after_update
      '/admin'
    end
end

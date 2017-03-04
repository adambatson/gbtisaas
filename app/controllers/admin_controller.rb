class AdminController < ApplicationController
  layout 'admin'

  def guestbooks
  	@open_books = Guestbook.where(archived: false)
  	@archived_books = Guestbook.where(archived: true)
  end

  def signatures
  end

  def access
  end

  def accounts
  end
end

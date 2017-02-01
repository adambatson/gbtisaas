class HomeController < ApplicationController
	def index
  	@admin_nav = false
  	@active_books = Guestbook.where(:archived => false)
  	@archived_books = Guestbook.where(:archived => true)

  	@current_book = Guestbook.first
  	@messages = @current_book.messages.where(:approved => true)
  end
end

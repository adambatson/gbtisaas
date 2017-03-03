class HomeController < ApplicationController
	def index
		@default_book = Guestbook.get_default
		@current_book = ( params.has_key?(:id) ) ? 
			Guestbook.where(id: params[:id].to_i).first : 
			@default_book
  	@guestbooks = Guestbook.all.where.not(id: @current_book.id).where.not(id: @default_book.id)
  end

  def about
  end
end

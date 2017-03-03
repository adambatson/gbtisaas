class HomeController < ApplicationController
	def index
		@default_book = Guestbook.get_default
		@current_book = ( params.has_key?(:id) ) ? 
			Guestbook.where(id: params[:id].to_i).first : 
			@default_book

		@sort_by = params.has_key?(:sort_by) ? params[:sort_by].to_sym : :recent
		@messages = @current_book.sorted_messages(@sort_by)
  	@guestbooks = Guestbook.all.where.not(id: @current_book.id).where.not(id: @default_book.id)
  end

  def about
  end
end

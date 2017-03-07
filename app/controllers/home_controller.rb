class HomeController < ApplicationController
	def index
		@default_book = Guestbook.get_default
		@current_book = ( params.has_key?(:id) ) ? 
			Guestbook.where(id: params[:id].to_i).first : 
			@default_book

		@sort_by = params.has_key?(:sort_by) ? params[:sort_by].to_sym : :recent
		@messages = @current_book.sorted_messages(@sort_by)
  	@guestbooks = Guestbook.all.
      where.not(id: @current_book.id).
      where.not(id: @default_book.id).
      where(visible: true)
    @title = "#{@current_book.title} - Guestbook"
  end

  def about
    @title = "About Us"
  end

  def has_voted id
    case cookies["last_vote_" + id.to_s]
    when "up"
      1
    when "down"
      -1
    else
      0
    end
  end

  helper_method :has_voted

end

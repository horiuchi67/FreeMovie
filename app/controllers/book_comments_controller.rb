class BookCommentsController < ApplicationController
	before_action :authenticate_user!
	def create
	    @book = Book.find(params[:book_id])
	    book_comment = current_user.book_comments.build(book_comment_params)
	    book_comment.book_id = @book.id
	    if book_comment.save
	    else
	    	@book = Book.find(params[:book_id])
	    	@user = @book.user
	    	@book_comment = BookComment.new
	    	flash[:notice] = "コメントを入力してください。"
	    	render 'books/show'
	    end
	end
	def destroy
		@book = Book.find(params[:book_id])
	    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
	end

	private
	def book_comment_params
	    params.require(:book_comment).permit(:comment)
	end
end

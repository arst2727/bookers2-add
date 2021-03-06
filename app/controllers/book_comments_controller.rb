class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "comment can't be blank<br>maximum is 200 characters"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end
  
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end

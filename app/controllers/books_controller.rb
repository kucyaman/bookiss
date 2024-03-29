class BooksController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :find_book, only: [:show, :edit, :update, :destroy]

  def index
    @book = current_user.books.order(created_at: :desc)
  end

  def show
    @page = if params[:page_number].present?
              @book.pages.find_by(page_number: params[:page_number])
            else
              nil
            end
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to new_book_page_path(book_id: @book.id)
    else
      flash.now[:danger] = "Bookの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: '絵本が更新されました。'
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @book.destroy!
    redirect_to books_path, status: :see_other
    flash[:success] = '削除が完了しました。'
  end

  private

  def book_params
    params.require(:book).permit(:title, :design_type, pages_attributes: [:id, :page_number, :photo, :content])
  end
end

def find_book
  @book = current_user.books.find(params[:id])
end

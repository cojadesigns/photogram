class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash.now[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your new post couldn't be created!  Please check the form."
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash.now[:alert] = "Post updated successfully!"
      redirect_to @post
    else
      flash.now[:alert] = "Update failed.  Please check the form."
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash.now[:success] = "Post deleted successfully"

      redirect_to posts_path
    else
      flash.now[:alert] = "Something went wrong, please check the form."
      render 'edit'
    end
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:caption, :image)
  end
end

class CommentsController < 
	before_action :find_post
	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:success] = "You commented the hell out of that post"
			redirect_to :back
		else
			flash[:error] = "Check the comment form. Something went horribly wrong"
			render root_path
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])

		@comment.destroy
		flash[:success] = "Comment was successfully deleted :("
		redirect_to root_path
	end

	private
	def comment_params
		params.require(:comment).permit(:content)
	end

	def find_post
		@post = Post.find(params[:id])
	end
end

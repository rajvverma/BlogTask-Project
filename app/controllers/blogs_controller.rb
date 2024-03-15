class BlogsController < ApplicationController
	before_action :set_blog, only: [:show, :edit, :update, :destroy]
	before_action :require_user
	before_action :require_same_user, only: [:edit, :update, :destroy]


	def index 
		@blogs = Blog.all
	end

	def create
		@blog = Blog.new(blog_params)
		@blog.user = current_user
		if @blog.save
            flash[:notice] = "Blog was created successfully"
            redirect_to blogs_path
        else
            render 'new'
        end
	end

	def new 
		@blog = Blog.new
	end

	def edit
	 end

	def update
	    if @blog.update(blog_params)
	      flash[:notice] = "Blog was updated successfully."
	      redirect_to blogs_path
	    else
	      render 'edit'
	   	end
	end

	def destroy
	    @blog.destroy
	    redirect_to blogs_path
	end

	def show
	end 

	private

	def blog_params
		params.require(:blog).permit(:title, :description)
	end

	def set_blog
    	@blog = Blog.find(params[:id])
  	end

  	def require_same_user
  	   if current_user != @blog.user
  	     flash[:alert] = "You can only edit or delete your own blog"
  	     redirect_to @blog
  	   end
  	end


end

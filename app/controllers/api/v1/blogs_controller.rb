class Api::V1::BlogsController < ApplicationController
	before_action :require_user

	def index
	   @blogs = Blog.all
	   render json: @blogs
	end

	private

	def require_user
	   unless logged_in?
	     render json: { error: 'Unauthorized. Please log in.' }, status: :unauthorized
	   end
	end
end

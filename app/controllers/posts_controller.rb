class PostsController < ApplicationController
    before_action :require_logged_in, except: [:show]
    before_action :require_user_owns_post!, only: [:edit, :update]

    def create
        @post = current_user.posts.new(post_params)
        @post.author_id = params[:user_id]
        @post.sub_id = params[:sub_id]

        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            # render :new
        end

    end

    def destroy
        @post = current_user.posts.find_by(id: params[:id])
        if @post && @post.delete
            redirect_to sub_url(@post.sub_id)
        end
    end

    def new
        @post = Post.new
        # render :new
    end

    
    def show
        @post = Post.find(params[:id])
        render :show
    end

    def edit
        @post = current_user.posts.find_by(id: params[:id])
        if @post
            render :edit
        else
            flash[:errors] = ["Post not owned by user"]
            redirect_to post_url(@post)
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params) # don't have to specify every attribute
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def post_params
        params.require(:post).permit(:url, :title, :content, :user_id, :sub_id)
    end

    def require_user_owns_post!
    return if current_user.posts.find_by(id: params[:id])
    render json: 'Forbidden', status: :forbidden
  end
end
class PostsController < ApplicationController
    before_action :require_logged_in, only: [:create, :edit, :update]

    def create
        @post = Post.new(post_params)
        @post.author_id = params[:user_id]
        @post.sub_id = params[:sub_id]

        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end

    end

    def destroy
        @post = current_user.find_by(:params[:id])
        if @post && @post.delete
            redirect_to sub_url(@post.sub_id)
        end
    end

    def new
        @post = Post.new
        render :new
    end

    
    def show
        @post = Post.find(params[:id])
        render :show
    end

    def edit
        @post = Post.find(params[:id])
        render :edit
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def post_params
        params.require(:post).permit(:title)
    end
end
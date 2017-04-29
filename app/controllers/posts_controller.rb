require 'will_paginate/array'
class PostsController < ApplicationController
     def index
        @post = Post.order('created_at DESC').page(params[:page])
        @all_users = User.all
    end
    
    def create
        @post = Post.new(postparams)
        @post.user_id = session[:user_id]
        @post.save
        redirect_to post_path(@post)
    end
    
    def new
        if current_user
            @post = Post.new
        else
            flash[:need_login] = " 안녕 !"
            redirect_to posts_path
        end
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def show
        @all_users = User.all

        if Post.where(:id => params[:id]).present?
           @post = Post.find(params[:id])
        else
            redirect_to posts_path, :flash => {:error => "저런! 글이 없어요." }
        end
    end
    
    def update
        @post = Post.find(params[:id])
        @post.update(postparams)
        redirect_to post_path(@post)
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
    
    def comment_write
        comment = Comment.new
        comment.content = params[:contents]
        comment.post_id = params[:postid]
        comment.user_id = session[:user_id]
        comment.save
        
        redirect_to post_path(@post)
    end
    
    private
    
    def postparams
      params.require(:post).permit(:title, :contents, :user_id)
    end
end

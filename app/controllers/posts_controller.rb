class PostsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

    def index
        @posts = Post.all

        if params[:search] == nil
            @posts= Post.all
          elsif params[:search] == ''
            @posts= Post.all
          else
            #部分検索
            @posts = Post.where("name LIKE ? ",'%' + params[:search] + '%')
          end

          if params[:tag]
            Tag.create(name: params[:tag])
          end

          if params[:tag_ids]
            @tweets = []
            params[:tag_ids].each do |key, value|
              if value == "1"
                tag_tweets = Tag.find_by(name: key).tweets
                @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
              end
            end
          end

    end

    def new
        @post = Post.new
      end

      def question
      end
    
      def create
        post = Post.new(post_params)
        post.user_id = current_user.id

        if post.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end
      def show
        @post = Post.find(params[:id])
      end
    
      def edit
        @post = Post.find(params[:id])
      end

      def update
        post = Post.find(params[:id])
        if post.update(post_params)
          redirect_to :action => "show", :id => post.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
      end
      private
      def post_params
        params.require(:post).permit(:name, :price, :about, :image, tag_ids: [])
      end
end

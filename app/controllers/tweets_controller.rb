# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :require_login
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

  def show; end

  def new
    @tweet = Tweet.new
  end

  def edit; end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html do redirect_to tweets_url, notice: 'ツイートが作成されました' end
        format.json { render :show, status: :created, location: @tweet }
      else
        @tweets = Tweet.all
        format.html do render :index end
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html do redirect_to @tweet, notice: 'ツイートが更新されました' end
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html do render :edit end
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html do redirect_to tweets_url, notice: 'ツイートが削除されました' end
      format.json { head :no_content }
    end
  end

  def timeline
    @tweets = Tweet.eager_load(user: :inverse_follows)
                   .where(follows: { follower_id: current_user.id })
    @tweet  = Tweet.new
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end

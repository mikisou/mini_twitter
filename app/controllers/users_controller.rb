# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show, :favorites, :follows, :followers]

  def index
    @users = User.all
  end

  def show; end

  def favorites; end

  def follows; end

  def followers; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

class Api::V1::ItemsController < ApplicationController
  before_action :authenticate!
  respond_to :json, :xml

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def create
    respond_with Item.create(item_params)
  end

  def update
    respond_with Item.update(params[:id], item_params)
  end

  def delete
    respond_with Item.destroy(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:id, :name, :description, :image_url)
  end

  def authenticate!
    authenticate_or_request_with_http_basic("Please authenticate to use my API")  do | email, password|
      user = User.find_by(email: email)
      if user && user.authenticate(password)
        true
      else
        head :unauthorized
      end
    end
  end
end

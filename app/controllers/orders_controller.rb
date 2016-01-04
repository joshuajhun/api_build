class OrdersController < ApplicationController
  respond_to :html, :json, :xml
  def index
    @orders = Order.all
    respond_with @orders
  end

  def show
    @order = Order.find(params[:id])
    respond_with @order
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      respond_to do |format|
        format.html {redirect_to orders_path, notice: "The order was created."}
        format.json {render json: @order}
        format.xml  {render xml:  @order}
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:notice]  = "Your order was not created"
          render :index
        end
      format.json {render json: @order.errors.full_messages, status: 400}
      format.xml  {render xml:  @order.errors.full_messages, status: 400}
      end
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      respond_to do |format|
        format.html {redirect_to item_path(@item), notice: "The order was updated."}
        format.json {render json: @order}
        format.xml  {render  xml: @order}
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:notice] = "The order failed to update"
          render :edit
        end
        format.json {render json: @order.errors.full_messages, status: 400}
        format.xml  {render  xml: @order.errors.full_messages, status: 400}
      end
    end 
  end

  private

  def order_params
    params.require(:order).permit(:amount, :user_id)
  end
end

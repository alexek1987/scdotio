class RequestsController < ApplicationController
  before_action :skip_all_authorization
  before_action :set_request, only: [:edit, :update, :show, :accept, :reject]

  def new
    @product = Product.find(params[:product_id])
    @request = Request.new(product: @product)
    authorize @request
  end

  def create
    @product = Product.find(params[:product_id])
    @request = Request.new(request_params)
    @request.product = @product
    @request.user = current_user
    authorize @request
    if @request.save
      sleep 4
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    authorize @request
    @review = Review.new
    @new_entry = Entry.new
    @entries = @request.entries
  end

  def edit
    authorize @request
  end

  def update
    authorize @request
    @request.update(request_params)
    redirect_to product_path(@product)
  end

  def accept
    authorize @product
    @request.update(status: "accepted")
    sleep 4
    redirect_to dashboard_path
  end

  def reject
    authorize @request
    @request.update(status: "rejected")
    sleep 4
    redirect_to dashboard_path
  end

  def completed
    authorize @request
    @request.update(status: "completed")
    redirect_to dashboard_path
  end

  private

  def skip_all_authorization
   skip_authorization
 end

  def request_params
    params.require(:request).permit(:content, :start_date, :end_date)
  end

  def set_request
    @request = Request.find(params[:id])
  end
end

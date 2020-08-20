class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.geocoded
    if params[:query].present?
      @products = @products.search_location_and_brand(params[:query]).geocoded
    else
      @products = Product.all
    end

    @markers = @products.map do |product|
      {
        lat: product.latitude,
        lng: product.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { product: product }),
        image_url: helpers.asset_url('dogpin'),
        id: product.id
      }
   end
  end

  def show
    @request = Request.new(product: @product)
    authorize @product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    @product.update(product_params)
    redirect_to product_path(@product)
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to root_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :brand, :age, :description, :address, photos: [])
  end
end

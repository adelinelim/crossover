class ProductsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if admin_signed_in?
      @products = Product.all
    else
      @products = Product.where(status: true)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if has_order_to_the_product?
      respond_to do |format|
        format.html { redirect_to products_url, alert: I18n.t(".products_controller.has_order_error") }
        format.json { render json: @product.errors.add(:order, I18n.t(".products_controller.has_order_error")), status: :unprocessable_entity }
      end
    else
      @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private

  def has_order_to_the_product?
    OrderLine.find_by(product_id: @product.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :image_url, :price, :status)
  end
end

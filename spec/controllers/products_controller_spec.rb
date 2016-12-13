require "rails_helper"

describe ProductsController do
  it "#index" do
    
    product = Product.create(name: "Apple", description: "fruit", image_url: "apple.jpg", price: 2, status: true)
    # product = create_list(:product, 1)

    get :index

    expect(response.status).to eq 200
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

customer = Customer.find_or_create_by!(firstname: "adeline", lastname: "lim", email: "adelineyiing@gmail.com", password: "qwe123123")
admin = Admin.find_or_create_by!(email: "admin@admin.com", password: "qwe123123")
product = Product.find_or_create_by!(name: "Apple", description: "fruit", image_url: "apple.jpg", price: 2.50, status: true)
product2 = Product.find_or_create_by!(name: "Shoes", description: "pink shoes", image_url: "pink_shoes.jpg", price: 79.90, status: true)
product3 = Product.find_or_create_by!(name: "Hat", description: "lady hat", image_url: "lady_hat.jpg", price: 49.90, status: true)
product4 = Product.find_or_create_by!(name: "Shirt", description: "man shirt", image_url: "man_shirt.jpg", price: 46.50, status: true)
order_no = OrderNo.find_or_create_by!(id: 1)
total_price = (2 * product.price) + product2.price
order = Order.find_or_create_by!(customer_id: customer.id, order_no: "O0000001", total: total_price, confirm_status: 2)
OrderLine.find_or_create_by!(order_id: order.id, product_id: product.id, quantity: 2, unit_price: product.price, total_price: 2.0 * product.price)
OrderLine.find_or_create_by!(order_id: order.id, product_id: product2.id, quantity: 1, unit_price: product2.price, total_price: product2.price)

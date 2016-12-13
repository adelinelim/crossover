# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


product = Product.find_or_create_by!(name: "Apple", description: "fruit", image_url: "apple.jpg", price: 2, status: true)
order = Order.find_or_create_by!(customer_id: 1, order_no: "aaa9994", total: 120, confirm_status: 2)
OrderLine.find_or_create_by!(order_id: order.id, product_id: product.id, quantity: 1, unit_price: 2, total_price: 2)

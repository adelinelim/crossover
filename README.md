# Simple E-Commerce Application
Build a small and very simple e-commerce application

# Features:
1. Customer forms
  ```
  Customer Login page
  Customer Registration page
  ```
2. Customer login to view Order List/ Cart
3. Customer Add a product to shopping cart
4. Customer make payment, which connect to the dummy payment gateway
5. List Products
6. Admin forms
  ```
  Admin Login page http://localhost:4000/admins/sign_in
  Admin Sign Up page http://localhost:4000/admins/sign_up
  ```
7. Only Admin user can add, edit and delete products

# Setup
1. Run the below command in console (terminal) to setup the ecommerce application
  (Note: This will only need to run once)
  ```
  ./run_once
  ```
  The below commands is what run_once file actually running:
  (Note: You don't need to run the below commands if you have already execute ./run_once)
  ```
  bundle exec bundle install
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:test:load
  bundle exec rake db:seed
  ```

# Start the Application:
1. Run the below command in console start the application
  ```
  ./start
  ```

2. When the server is started, go to browser
  ```
  http://localhost:4000
  ```

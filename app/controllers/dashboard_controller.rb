class DashboardController < ApplicationController

  def index
    
  end

  def orm
    sql = "CREATE TABLE customer_privileges ( customer_id int, privilege_id int);"
    results = ActiveRecord::Base.connection.execute(sql).to_a
    puts results

    drop_table = "DROP TABLE IF EXISTS customer_privileges;"
    ActiveRecord::Base.connection.execute(drop_table)

    ActiveRecord::Base.clear_active_connections!

  rescue Exception => e
    ActiveRecord::Base.connection.execute(sql)
    puts e
    Rails.logger.warning("Random SQL query failed")
    ActiveRecord::Base.clear_active_connections!
  end

  def slowdb
    query  = "SELECT
              customers.id,
              customers.first_name,
              customers.last_name,
              customers.email_address,
              customers.mobile_phone,
              orders.id AS order_id,
              orders.shipping_fee,
              orders.taxes
              FROM customers
              LEFT JOIN orders ON customers.id = orders.customer_id
              UNION
              SELECT
              customers.id,
              customers.first_name,
              customers.last_name,
              customers.email_address,
              customers.mobile_phone,
              orders.id AS order_id,
              orders.shipping_fee,
              orders.taxes
              FROM customers
              RIGHT JOIN orders ON customers.id = orders.customer_id
              ORDER BY id;"
    results = ActiveRecord::Base.connection.execute(query).to_a
    ActiveRecord::Base.clear_active_connections!
    puts results
  end


  def slowrequest
    query =  "SELECT
              orders.id,
              orders.order_date,
              orders.shipped_date,
              orders.shipping_fee,
              orders.taxes,
              orders.payment_type,
              orders_status.id AS status_id,
              orders_status.status_name
              FROM orders
              LEFT JOIN orders_status
              ON orders.id = orders_status.id
              ORDER BY order_date;"
    results = ActiveRecord::Base.connection.execute(query).to_a
    ActiveRecord::Base.clear_active_connections!
    puts results
  end

  def swallowedexception
    query = "SELECT
              purchase_orders.id,
              purchase_orders.supplier_id,
              purchase_orders.created_by,
              purchase_orders.creation_date,
              purchase_orders.shipping_fee,
              purchase_orders.taxes,
              purchase_orders.payment_amount,
              purchase_orders.payment_method,
              purchase_order_status.id AS status_id,
              purchase_order_status.status
              FROM purchase_order_status
              RIGHT JOIN purchase_orders
              ON purchase_order_status.id = purchase_orders.status_id
              ORDER BY creation_date;"
    results = ActiveRecord::Base.connection.execute(query).to_a
    ActiveRecord::Base.clear_active_connections!
    puts results
  end

  def untracked
  
  end
end
require 'net/http'
require 'uri'
class BadAppController < ApplicationController

  add_flash_types :danger, :info, :warning, :success

  def orm
    results = ''
    get_rows = 'SELECT id, first_name, last_name, city, country_region, mobile_phone FROM customers;'
    rows = ActiveRecord::Base.connection.exec_query(get_rows)
    ActiveRecord::Base.clear_active_connections!
    puts rows
    rows.each do |row|
      sql = "SELECT id, order_date, employee_id, customer_id, shipping_fee, taxes, payment_type FROM orders WHERE customer_id = #{row["id"]} LIMIT 1;"
      results = ActiveRecord::Base.connection.execute(sql).to_a
      ActiveRecord::Base.clear_active_connections!
      puts results
    end

    if results.present?
      flash[:success] = "ORM SQL query executed succesfully!"
      Rails.logger.info("ORM SQL query executed succesfully")
    else 
      flash[:danger] = "ORM SQL query went wrong!"
      Rails.logger.info("ORM SQL query failed")
    end
    redirect_back(fallback_location: root_path)
  rescue Exception => e
    puts e
    flash[:danger] = "ORM SQL query encountered an exception!"
    Rails.logger.warn("ORM SQL query encountered an exception!")
  end

  def slowdb
    results = ActiveRecord::Base.connection.execute("call 5sec_proc()")
    ActiveRecord::Base.clear_active_connections!
    puts results

    if results.present?
      flash[:success] = "SQL stored procedure successfully executed!"
      Rails.logger.info("SlowDB SQL query executed succesfully")
    else 
      flash[:danger] = "SQL stored procedure query went wrong!"
      Rails.logger.info("SlowDB SQL query failed")
    end
    redirect_back(fallback_location: root_path)
  end


  def slowrequest
    if ENV['API_ENDPOINT'].present?
      call_api = ENV['API_ENDPOINT'] + params[:apicall]
      response = Api.do_get_request(call_api)
 
      if response.kind_of? Net::HTTPSuccess
        flash[:success] = "Successful API call"
        Rails.logger.info("SlowRequest API called successfully")
      else
        flash[:danger] = "Unsuccessful API call, please try again"
        Rails.logger.error("SlowRequest API call failed")
      end
    else
      flash[:warning] = "Please make sure you have added an API URL"
    end
    redirect_back(fallback_location: root_path)
  end

  def swallowedexception
    begin
      raise CustomException.new
      flash[:danger] = "Swallowed exception failed!"
      Rails.logger.info("SwallowedException failed")
    rescue CustomException => e
      flash[:success] = "Swallowed exception as intended!"
      Rails.logger.info("SwallowedException successful")
    end
    redirect_back(fallback_location: root_path)
  end

  def untracked
    results = ActiveRecord::Base.connection.execute("call bad_getsupplierid_proc()")
    ActiveRecord::Base.clear_active_connections!
    puts results

    flash[:info] = "Untracked call successfully executed!"
    Rails.logger.info("Untracked application call executed succesfully")
    redirect_back(fallback_location: root_path)
  end
end 
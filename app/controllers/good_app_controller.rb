require 'net/http'
require 'uri'
class GoodAppController < ApplicationController

  add_flash_types :danger, :info, :warning, :success

  def orm
    results = ActiveRecord::Base.connection.execute("call good_getsupplierid_proc()")
    ActiveRecord::Base.clear_active_connections!
    results.each do |result|
      puts result
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
    results = ActiveRecord::Base.connection.execute("call Ssec_proc()")
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
      # raise CustomException.new
    rescue CustomException => e
      flash[:danger] = "Swallowed exception failed!"
      Rails.logger.info("SwallowedException failed")
    end
    flash[:success] = "Swallowed exception as intended!"
    Rails.logger.info("SwallowedException successful")
    redirect_back(fallback_location: root_path)
  end

  def untracked
    results = ActiveRecord::Base.connection.execute("call good_getsupplierid_proc()")
    ActiveRecord::Base.clear_active_connections!
    puts results

    flash[:info] = "Untracked call successfully executed!"
    Rails.logger.info("Untracked application call executed succesfully")
    redirect_back(fallback_location: root_path)
  end
end 
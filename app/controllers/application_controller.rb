class ApplicationController < ActionController::Base

  protect_from_forgery

  protected

  def filters(relation)
    where_string = []
    where_params = []
    if params[:name]
      where_string << "name ilike ?" 
      where_params << "%#{params[:name]}%"
    end

    if params[:played_at_total_min]
      where_string << "played_at >= ?"
      where_params << params[:played_at_min].to_time
    end

    if params[:played_at_total_max]
      where_string << "played_at >= ?"
      where_params << params[:played_at_max].to_time
    end

    if params[:min_age]
      where_string << "age >= ?"
      where_params << params[:min_age]
    end
    
    if params[:max_age]
      where_string << "age <= ?"
      where_params << params[:max_age]
    end


    #TODO add hourly, monthly, seasonly, yearly

    limit = 100
    if params[:limit]
      limit = params[:limit].to_i 
    end
    order = nil
    if params[:order_by] and params[:order_dir]
      order = "#{params[:order_by]} #{params[:order_dir]}"   
    end
    select = nil
    if params[:select]
      select = params[:select] 
    end
    group = nil
    if params[:group]
      group = params[:group] 
    end
    includes = process_includes(params[:include])    
    conditions = [where_string.join(" AND "), where_params]
    relation.where(conditions).order(order).limit(limit).includes(includes).group(group).select(select)
  end

  def process_includes(include_string)
    include_string ? include_string.split(",").map(&:to_sym) : nil
  end
end

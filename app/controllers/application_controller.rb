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
    
    
    #pass parameter for example played_at_hour_min
    %w(year month day hour minute).each do |date_part|
      %w(min max).each do |bound|
        sign = bound == "min" ? ">=" : "<="
        parameter = "played_at_#{date_part}_#{bound}".to_sym
        if params[parameter]
          where_string << "date_part('#{date_part}', track_plays.played_at) #{sign} ? "
          where_params << params[parameter]
        end
      end
    end

    if params[:min_age]
      where_string << "age >= ?"
      where_params << params[:min_age]
    end

    if params[:max_age]
      where_string << "age <= ?"
      where_params << params[:max_age]
    end

    if params[:country_id]
      where_string << "country_id = ?"
      where_params << params[:country_id]
    end

    if params[:gender]
      where_string << "gender = ?"
      where_params << User.gender_to_index(params[:gender])
    end

    #May cause problems with aggrigates
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

    joins = nil
    if params[:joins]
      joins = params[:joins]
    end

    includes = process_includes(params[:include]) 
    conditions = [where_string.join(" AND "), *where_params]
    relation.select(select).includes(includes).where(conditions).order(order).limit(limit).group(group).joins(joins)
  end

  def process_includes(include_string)
    include_string ? include_string.split(",").map(&:to_sym) : nil
  end
end

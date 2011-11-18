class ActiveRecord::Base
  def self.random(limit=1)
    num_records = count
    result = all :offset => rand(count), :limit => limit
    result.length == 1 ? result.pop : result
  end

  def to_html
    self.attributes.map{|k,v| "<b>#{k}:</b> #{v}"}.join("<br/>\n")
  end
end

class Array
  #TODO this is bad, should do that only on associations of models
  def to_html
    self.map(&:to_html).join("<hr />")
  end
end


class Status < ActiveRecord::Base
  def self.formatted_all_records
    Status.all.map {|t| [t.name, t.name]}
  end
end

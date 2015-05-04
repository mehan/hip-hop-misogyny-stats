class Rapper < ActiveRecord::Base
validates :name, presence: true, uniqueness: true


def overall_score
pussy_count + bitch_count + ho_count
end
  
end


module Rapidfire
  class Survey < ActiveRecord::Base
    
    def to_param  # overridden
      id/api_id
    end
    
    has_many  :attempts
    has_many  :questions
    has_many :attempts

    validates :name, :presence => true
  end
end

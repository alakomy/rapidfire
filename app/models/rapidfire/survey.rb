module Rapidfire
  class Survey < ActiveRecord::Base
    belongs_to :location

    has_many   :attempts
    has_many   :questions
    has_many   :attempts

    validates :name, presence: true


    def to_param  # overridden
      api_id
    end


  end
end

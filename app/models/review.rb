class Review < ActiveRecord::Base
    belongs_to :movie
    validates :body,  presence: true, length: { maximum: 200 , minimum: 2 }
end

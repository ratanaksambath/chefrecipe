class Like < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe

  validates_uniqueness_of :chef, scope: :recipe #each chef can only like or dislike recipe once
end
class Chef < ActiveRecord::Base
  has_many :recipes

  before_save {self.email = email.downcase}
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :chefname, presence: true, length: {minimum: 3, maximum: 40}
  validates :email, presence: true, length: {maximum: 105},
             uniqueness: {case_sensitive: false},
             format: {with: EMAIL_FORMAT}
# call back method (before_save) is use to have the object do the scope condition before it saved to the database


end
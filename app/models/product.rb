class Product < ActiveRecord::Base
  attr_accessible :amount, :name

  belongs_to :customer
  belongs_to :sale

  has_many :category
end

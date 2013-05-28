class Sale < ActiveRecord::Base
  attr_accessible :date, :name

  belongs_to :customer
  has_many :products
end

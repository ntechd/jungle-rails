class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true
  
  scope :total_product_count, -> { Product.count }
  scope :product_count_by_category, ->(id) { where(category_id: id).count }
  scope :sold_out?, ->(id) { where(id: id).first }

end

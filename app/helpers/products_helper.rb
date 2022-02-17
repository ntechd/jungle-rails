# frozen_string_literal: true

module ProductsHelper
  def total_product_count
    Product.total_product_count
  end

  def sold_out?(id)
    product = Product.sold_out?(id)
    product.quantity.zero?
  end 
end

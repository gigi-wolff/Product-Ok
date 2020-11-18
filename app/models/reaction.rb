class Reaction < ApplicationRecord
  belongs_to :allergen
  belongs_to :product
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  def reactive_allergen_category   
     return Allergen.find(self.allergen_id).category
  end

  def reactive_allergen_substances
    return self.reactive_substances.split(';')
  end

  def reactive_product_name   
     return Product.find(self.product_id).name
  end

end
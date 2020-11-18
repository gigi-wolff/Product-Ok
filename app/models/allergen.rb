class Allergen < ApplicationRecord
  #The model should be able to answer the question "Can user x do y to this object?"
  #When you write regular methods in the model those methods are all instance methods.  
  #In other words def some_method will be a method available on each retrieved record

  # dependent: :destroy, rails will destroy all reactions associated with Allergen when its deleted
  has_many  :reactions, dependent: :destroy
  # A has_many :through association is often used to set up a many-to-many connection 
  # with another model (Reaction). This association indicates that the declaring model (Allergen) can be 
  # matched with zero or more instances of another model (Product) by proceeding through a third model (Reaction).
  has_many  :products, through: :reactions
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :category, presence: true
  #to validate more than one column (or more), you can add that to the scope
  validates_uniqueness_of :category, presence: true, :case_sensitive => false, :scope => [:user_id], length: {minimum: 3}
  validates :substances, presence: true, length: {minimum: 3}
  #Match any characters as few as possible until a ";" is found, without counting the ";".
  validates :substances, format: { with: /.+?(?=;)/, :message => "must end with or be seperated by a ';'" }
  
  #remove newline(\n) and return(\r) from substances attribute
  def substances=(value)
    write_attribute(:substances, value.gsub("\n","").gsub("\r",""))
  end

  def get_substances
    return self.substances.split(';')
  end

  # array of substances match the ingredient
  def matching_substances_to(ingredient)
    matching_substances = []
    # does ingredient match any substance in this allergen category 
    matching_substances = self.get_substances.select {|substance| 
        (ingredient.upcase.include?(substance.upcase) || substance.upcase.include?(ingredient.upcase))
      } 
    return matching_substances
  end

  # After allergen has been created or updated (and saved) check all products for
  # this allergen
  after_save do |allergen|
    if Product.any?
      Product.find_each {|product| product.check_for_allergens}
    end
  end 

end
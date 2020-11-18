class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :get_allergen_choices, only: [:create]

# The purpose of the controller is to manage the incoming request and session

  def index
    @menu = Menu.all 
    @selected_categories = Allergen.where('user_id = ?',current_user).pluck(:category)
    render 'menus/index'
  end

  # POST '/menus'
  # the general pattern used in the action create that handles
  # submission of model-backed forms 
  def create 
    # the form displayed in "index.html.erb" is submitted to action='/create' 
    # using verb method="post" which is routed to allergens#create.
    # @allergen, is populated with values (params) submitted from the form
    @selected_allergens.each do |allergen| 
      Allergen.find_or_create_by(category: allergen.category, substances:allergen.substances, user_id:current_user.id)
    end
    flash[:success] = "Allergens successfully updated"
    # redirect must be a url, can't render a view template
    # (add '_path' to the prefix to get the url)
    redirect_to allergens_path # allergens/index
  end


  private 

  def get_allergen_choices
    @selected_allergens = Menu.where(id: params[:allergen_id])
    # find all unchecked categories
    unchecked_categories = Menu.find(Menu.all.pluck(:id) - @selected_allergens.pluck(:id)).pluck(:category)
    # delete all unchecked categories from Allergen db if they exists
    unchecked_categories.each {|unchecked_category| Allergen.find_by_category(unchecked_category).try(:destroy)}
  end  

end
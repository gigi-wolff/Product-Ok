class ChangeGroupDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:menus, :group, "")
  end
end

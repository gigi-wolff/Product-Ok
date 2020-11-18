class ChangeSelectedToGroup < ActiveRecord::Migration[5.1]
  def change
    rename_column(:menus, :selected, :group)
  end
end

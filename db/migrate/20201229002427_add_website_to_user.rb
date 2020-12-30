class AddWebsiteToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :web, :string
    add_column :users, :phone, :integer
    add_column :users, :sex, :string
  end
end

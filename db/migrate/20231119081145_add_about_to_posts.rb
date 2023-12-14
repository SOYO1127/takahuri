class AddAboutToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :about, :text
  end
end

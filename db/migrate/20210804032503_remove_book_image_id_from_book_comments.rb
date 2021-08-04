class RemoveBookImageIdFromBookComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_comments, :Book_image_id, :string
  end
end

class AddAvarageRating < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :avarage_rating, :string, default: '0'
  end
end

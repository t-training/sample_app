class AddAccessDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :access_digest, :string
  end
end

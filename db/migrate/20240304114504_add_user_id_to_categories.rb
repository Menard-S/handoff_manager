class AddUserIdToCategories < ActiveRecord::Migration[7.1]
  def up
    add_reference :categories, :user, null: true, foreign_key: true
    
    user = User.find_by(email: 'User1@handoff.com')
    if user
      Category.update_all(user_id: user.id)
    else
      raise ActiveRecord::IrreversibleMigration, "User1@handoff.com not found."
    end

    change_column_null :categories, :user_id, false
  end
  
  def down
    remove_reference :categories, :user, foreign_key: true
  end
end

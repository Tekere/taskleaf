class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up

    add_reference :tasks, :user, foreign_key: true
  end
  
  def down
    remove_reference :tasks, :user
  end
end

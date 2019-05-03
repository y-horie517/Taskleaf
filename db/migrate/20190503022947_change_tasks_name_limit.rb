class ChangeTasksNameLimit < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :name, :string, limit: 30
  end

  # 取り消しの際にはこちらが実行され、制約が取れる
  def down
    change_column :tasks, :name, :string
  end
end

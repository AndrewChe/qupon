class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :nick_name
      t.string :photo

      t.timestamps
    end
  end
end

class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :body
      t.string :language

      t.timestamps null: false
    end
  end
end

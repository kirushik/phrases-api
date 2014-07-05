class CreateTablePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :value

      t.timestamps
    end
  end  
end
class ValidatePhraseUniqueness < ActiveRecord::Migration
  def change
    change_table :phrases do |t|
      t.string :canonical_value
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE phrases
          SET canonical_value = lower(value)
        SQL
      end
    end

    add_index :phrases, :canonical_value, unique: true
  end  
end
class Phrase < ActiveRecord::Base
  def self.random
    # We will use SQL-based finder with random-offset technique
    # because the most common order-by-rand approach is slow due to full table load required
    find_by_sql(
      'SELECT * FROM phrases OFFSET trunc (RANDOM() * (SELECT COUNT(*) FROM phrases)) LIMIT 1'
    ) # Warning! This is PostgreSQL-specific due to RANDOM() function call
  end
end
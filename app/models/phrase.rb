class Phrase < ActiveRecord::Base
  # Normally, one should not use DB as a validation tool and declare validations here,
  # with ActiveRecord helpers.
  # But in our case we've already used pg-only syntax, so we can squeeze some speed with DB-base validations
  before_save do
    self.canonical_value=self.value.mb_chars.downcase.to_s # This trick works with non-ascii characters
  end

  def self.random
    # We will use SQL-based finder with random-offset technique
    # because the most common order-by-rand approach is slow due to full table load required
    find_by_sql(
      'SELECT * FROM phrases OFFSET trunc (RANDOM() * (SELECT COUNT(*) FROM phrases)) LIMIT 1'
    ) # Warning! This is PostgreSQL-specific due to RANDOM() function call
  end
end
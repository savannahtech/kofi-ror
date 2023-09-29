class User < ApplicationRecord
  has_many :hits

  def cached_count_hits
    Rails.cache.fetch("user_#{id}_hit_counts", expires_in: 10.minutes) do
      count_hits
    end
  end

  # This is results in an expensive query so we wouldn't call it often
  def count_hits
    start = Time.now.in_time_zone(timezone).beginning_of_month
    hits.where('created_at > ?', start).count
  end

  # Example timezone for user in Australia
  def timezone
    'Australia Timezone'
  end
end

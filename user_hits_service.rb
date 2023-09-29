class UserHitsService
  attr_reader :user, :expires_in

  def initialize(user:, expires_in: 10.minutes)
    @user = user
    @expires_in = expires_in
  end

  def execute
    cached_count_hits
  end

  private

  def cached_count_hits
    Rails.cache.fetch("user_#{user.id}_hit_counts", expires_in:) do
      start = Time.now.in_time_zone(user.timezone).beginning_of_month
      user.hits.where('created_at > ?', start).count
    end
  end
end

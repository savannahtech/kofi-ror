class User < ApplicationRecord
  has_many :hits

  def count_hits
    UserHitsService.new(user: self).execute
  end

  # Example timezone for user in Australia
  def timezone
    'Australia Timezone'
  end
end

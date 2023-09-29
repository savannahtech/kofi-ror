class UpdateUserQuotaJob < ApplicationJob
  def perform(user_id, endpoint)
    user = User.find user_id

    Time.use_zone(user.time_zone) do
      user.hits.create!(endpoint)
    end
  end
end

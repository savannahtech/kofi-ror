class ApplicationController < ActionController::API
  before_action :check_user_quota
  after_action :update_user_quota

  private

  def check_user_quota
    render json: { error: 'over quota' } if current_user.cached_count_hits >= 10_000
  end

  def update_user_quota
    UpdateUserQuotaJob.perform_later(current_user.id, req.endpoint)
  end
end

class ApplicationController < ActionController::API
  include Ratelimiter

  before_action :authenticate_user!, :check_user_quota
  after_action :update_user_quota

  rescue_from Ratelimiter::RatelimitedError do |e|
    render json: { message: e.message }, status: :too_many_requests
  end

  private

  def authenticate_user!
    ratelimit!('user-ip', request.ip, threshold: 10, interval: 3600)

    # other implementation of this method below...
  end

  def check_user_quota
    render json: { error: 'over quota' } if current_user.cached_count_hits >= 10_000
  end

  def update_user_quota
    UpdateUserQuotaJob.perform_later(current_user.id, req.endpoint)
  end
end

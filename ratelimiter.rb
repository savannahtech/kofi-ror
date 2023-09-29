# frozen_string_literal: true

module Ratelimiter
  RatelimitedError = Class.new(StandardError)

  # using the ratelimt gem to implement a custom rate limiter

  def ratelimit!(action, subject, threshold:, interval: 3600)
    ratelimit = Ratelimit.new(action, redis: Redis.new(url: ENV['REDIS_CACHE_URL']))

    unless ratelimit.exceeded?(subject, threshold:, interval:)
      ratelimit.add(subject)
      return
    end

    raise RatelimitedError, 'Too many requests'
  end
end

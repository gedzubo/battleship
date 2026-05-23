class HeartbeatsController < ApplicationController
  def create
    UserPresenceService.touch(Current.user)

    head :ok
  end
end

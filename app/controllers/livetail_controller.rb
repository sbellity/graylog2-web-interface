class LivetailController < ApplicationController
  def index
    @hide_stats = true
    @content_class = 'live'
  end
end

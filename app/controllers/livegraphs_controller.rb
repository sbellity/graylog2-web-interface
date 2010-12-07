class LivegraphsController < ApplicationController
  def index
    @load_flot = true
    @hide_stats = true
  end
end

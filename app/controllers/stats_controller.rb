class StatsController < ApplicationController
  def index
    db_stats = Stat.order(id: :desc).includes(:machine).limit(Machine.count)
    gon.stats = json_collection.new(db_stats, each_serializer: ::StatSerializer)
    gon.models = Machine.models.keys
  end

end

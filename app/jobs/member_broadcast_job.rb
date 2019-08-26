class MemberBroadcastJob < ApplicationJob
  queue_as :default

  def perform(owner, entrant)
    ActionCable.server.broadcast "room_channel_#{owner.room_id}", member: render_member(owner, entrant)
  end

  private
    def render_member(owner, entrant)
    	ApplicationController.renderer.render(partial: 'room/member', locals: {owner: owner, entrant: entrant})
    end
end

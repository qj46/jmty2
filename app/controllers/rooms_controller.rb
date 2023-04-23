class RoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    room = Room.create
    current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
    another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: room.id)
    redirect_to room_path(room)
  end

  def show
    # ログインユーザーがエントリーしてないルームは入れない
    @user = Room.find_by_id(params[:id]).entries.find_by(user_id: current_user.id)
    redirect_to dashboard_path if @user.nil?

    
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.find { |entry| entry.user_id != current_user.id }
  end
end
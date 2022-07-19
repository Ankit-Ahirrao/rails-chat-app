class RoomsController < ApplicationController

  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = Room.all 
  end

  def show
    @rooms = Room.all  
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
  end

  def new
    @room = Room.new
  end

  def create 
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = "#{@room.name} is created successfully"
      redirect_to rooms_path 
    else 
      render :new
    end 
  end

  def edit 
  end

  def update 
    if @room.update(room_params)
      flash[:success] = "#{@room.name} is updated successfully"
      redirect_to rooms_path
    else  
      render :edit
    end
  end

  private 

  def set_room 
    @room = Room.find(params[:id])
  end

  def room_params 
    params.require(:room).permit(:name)
  end
end

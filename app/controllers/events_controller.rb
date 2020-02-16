class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :delete]

  def index
    @events_current = Event.not_yet_happened
    @events_past = Event.already_happened
  end

  def current
    @events = Event.not_yet_happened
  end

  def past
    @events = Event.already_happened
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to @event
    elsif @event.name.empty?
      render :new 
    else
      render :new 
    end
  end

  def show
  end

  def edit
  end

  def update
    @event.update(name: event_params[:name], start_date: event_params[:start_date], end_date: event_params[:end_date], location: event_params[:location])
    if @event.save
      flash[:green] = "Event has been updated."
      redirect_to @event
    else
      render :edit
    end
  end

  def delete
  end

  def destroy
    @event.destroy
    flash[:red] = "Event has been deleted."
    redirect_to events_path
  end

  private
  
  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end

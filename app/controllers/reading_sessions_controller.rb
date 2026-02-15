class ReadingSessionsController < ApplicationController
  before_action :require_login

  def index
    @reading_sessions = current_user.reading_sessions.includes(:book).order(date: :desc)
    @reading_session = ReadingSession.new
  end

  def create
    @reading_session = current_user.reading_sessions.new(reading_session_params)

    if @reading_session.save
      redirect_to reading_sessions_path, notice: 'Reading session was successfully logged.'
    else
      @reading_sessions = current_user.reading_sessions.includes(:book).order(date: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def reading_session_params
    params.require(:reading_session).permit(:pages_read, :duration_minutes, :date, :book_id)
  end
end
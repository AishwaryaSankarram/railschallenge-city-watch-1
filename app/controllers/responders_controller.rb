class RespondersController < ApplicationController
  before_action :reject_unpermitted_parameters, only: [:create, :update]

  def index
    @responders = Responder.all
  end

  def show
    @responder = Responder.find_by!(name: params[:id])
  end

  def create
    @responder = Responder.new(responder_params)
    if @responder.save
      render 'show', status: :ok
    else
      render_errors_for @responder
    end
  end

  def update
    @responder = Responder.find_by!(name: params[:id])
    if @responder.update_attributes(responder_params)
      render 'show', status: :ok
    else
      render_errors_for @responder
    end
  end

  def destroy
    @responder = Responder.find_by!(name: params[:id])
  end

  private

  def responder_params
    params.require(:responder).permit(:name,
                                      :type,
                                      :capacity,
                                      :on_duty)
  end

  def unpermitted_parameters
    if params[:action] == 'create'
      [:id, :emergency_code, :on_duty]
    elsif params[:action] == 'update'
      [:id, :capacity, :emergency_code, :type, :name]
    else
      []
    end
  end
end

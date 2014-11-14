class Api::AdvertisementsController < ApplicationController
  before_action :authenticate_user!, except: :show
  def show
    @advertisement = Advertisement.find(params[:id])
    render js: {name: @advertisement.name, phone: @advertisement.phone}.to_json
  end
end
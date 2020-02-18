class SpecsController < ApplicationController
  before_action :set_package, except: [:create, :destroy]

  def edit
  end

  def new
    @spec = Spec.new
  end
  
  def create
    Spec.create(params[:spec].permit(:perk_id, :package_id, :qty))
    redirect_back fallback_location: @package
  end

  def destroy
    spec = Spec.find(params[:id])
    spec.destroy
    redirect_back fallback_location: @package
  end

  private

  def set_package
    @package = Package.find(params[:package_id])
  end
end

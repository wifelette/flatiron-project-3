class PackagesController < ApplicationController
  before_action :set_event
  before_action :set_package, only: [:show, :edit, :update]

  def index
    @packages = Package.where(event_id: params[:event_id])
  end

  def new
    @package = Package.new
  end

  def create
    package = @event.packages.build(package_params)

    if package.save
      redirect_to [@event, package]
    else
      flash[:red] = "Package did not save."
      redirect_to new_event_package_url 
    end
  end

  def edit
  end

  def update
    @package.update(name: package_params[:name], price: package_params[:price])
    if @package.save
      flash[:green] = "Package has been updated."
      redirect_to [@event, @package]
    else
      flash[:red] = "You submitted invalid data."
      redirect_to edit_event_package_url
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_package
    @package = Package.find(params[:id])
  end

  def package_params
    params.require(:package).permit(:name, :price)
  end
end

class PackagesController < ApplicationController
  before_action :set_event
  before_action :set_package, except: [:index, :new, :create]
  # Previously I had `only: [:show, :edit, :update, :destroy]`, but this is shorter. As the list gets longer, check to reevaluate which is more efficient.

  def index
    # Limit the Index here to only the packages that are in a specific Event.
    @packages = Package.where(event_id: params[:event_id])
  end

  def new
    @package = Package.new
  end

  def create
    @package = @event.packages.build(package_params)

    if @package.save
      redirect_to [@event, @package]
    else
      render :new 
    end
  end

  def edit
  end

  def update
    @package.update(package_params)
    
    if @package.save
      flash[:green] = "Package has been updated."
      redirect_to [@event, @package]
    else
      flash[:red] = "You submitted invalid data."
      redirect_to edit_event_package_url
    end
  end

  def delete
  end

  def destroy
    @package.destroy
    flash[:red] = "Package has been deleted."
    redirect_to @event
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

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
    @package.specs = Perk.all.map { |perk| Spec.new(qty: 0, perk: perk) }
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
    missing_perks = Perk.all - @package.specs.map(&:perk)
    missing_perks.each do |perk|
      @package.specs.build(qty: 0, perk: perk)
    end
  end

  def update
    package_params[:specs_attributes].each do |_k, v|
      # If the spec existed and the quantity was reduced to 0,
      # mark the attribute with `_destroy`, which will tell
      # the update method to destroy the association / Spec record
      if v["id"] && v["qty"] == "0"
        v["_destroy"] = true
      end
    end

    @package.update(package_params)

    if @package.save
      flash[:green] = "Package has been updated."
      redirect_to [@event, @package]
    else
      flash[:red] = "You submitted invalid data."
      redirect_to edit_event_package_url
      # Should this be render :edit?? If there were errors yes so we could use/see them, but this right now is just to catch bugs—there shouldn't be anhy use case where you can hit this clause in the logic
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
    @package_params ||= params.require(:package).permit(:name, :price, specs_attributes: [:qty, :perk_id, :id])
  end
end

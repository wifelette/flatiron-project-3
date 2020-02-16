class PerksController < ApplicationController
  before_action :set_perk, only: [:show, :edit, :update, :destroy, :delete]

  def index
    @perks = Perk.all
  end

  def new
    @perk = Perk.new
  end

  def create
    @perk = Perk.create(perk_params)
    if @perk.save
      redirect_to @perk
    else
      render :new 
    end
  end

  def show
  end

  def edit
  end

  def update
    @perk.update(name: perk_params[:name], description: perk_params[:description], deliverable: perk_params[:deliverable], limited: perk_params[:limited], paid_addon: perk_params[:paid_addon])
    if @perk.save
      flash[:green] = "Perk has been updated."
      redirect_to perks_path
    else
      flash[:red] = "Your Perk update wasn't saved."
      render :edit
    end
  end

  def delete
  end

  def destroy
    @perk.destroy
    flash[:red] = "Perk has been deleted."
    redirect_to perks_path
  end

  private
  
  def perk_params
    params.require(:perk).permit(:name, :description, :deliverable, :limited, :paid_addon)
  end

  def set_perk
    @perk = Perk.find(params[:id])
  end
end

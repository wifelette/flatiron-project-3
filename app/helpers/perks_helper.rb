module PerksHelper
  def perk_use_count
    @perk.packages.count
  end
end

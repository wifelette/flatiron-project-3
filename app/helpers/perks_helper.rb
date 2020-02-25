module PerksHelper
  def perk_use_count
    @perk.packages.count
  end

  def status_mark(value)
    value ? "✅" : "❌"
  end
end

module ApplicationHelper
  def prettydate(date)
    date.strftime("%A, %B %d, %Y")
  end
end

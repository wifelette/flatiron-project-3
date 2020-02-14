module ApplicationHelper
  def prettydate(date)
    if date.present?
      # Sometimes there's no @event.date; it's not required.
      date.strftime("%A, %B %d, %Y")
    end
  end
end

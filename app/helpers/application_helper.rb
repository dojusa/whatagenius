module ApplicationHelper
  def error_messages(resource)
    render('shared/error_messages', resource: resource)
  end
end

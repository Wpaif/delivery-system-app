module ApplicationHelper
  def capitalize_name(name)
    name.split(' ').map(&:capitalize).join(' ')
  end
end

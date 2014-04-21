module SnippetsHelper

  def select_status
    statuses = %w{ all smelly cleaned }
    statuses.inject([]) do |statuses, status|
      statuses << [
          status.capitalize,
          status
      ]
    end
  end

  def select_posted
    labels = ['today', 'yesterday', 'this week', 'this month']
    labels.inject([]) do |labels, label|
      labels << [
          label.capitalize,
          label.gsub(' ', '_')
      ]
    end
  end

end

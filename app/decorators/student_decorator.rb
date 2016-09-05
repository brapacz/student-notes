class StudentDecorator < BaseDecorator
  def full_name
    "#{first_name} #{last_name}"
  end

  def avg_notes(subject_item)
    '%0.2f' % mean(subject_item.subject_item_notes.pluck(:value))
  end

  private

  def mean(list)
    return 0 if list.empty?
    list.reduce(0.00, :+) / list.count
  end
end

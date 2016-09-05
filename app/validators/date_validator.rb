class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value

    if options[:eariel_than] && value > parse_date(options[:eariel_than])
      record.errors[attribute] << (options[:message] || "is later than") % parse_date(options[:eariel_than])
    end

    if options[:later_than] && value < parse_date(options[:later_than])
      record.errors[attribute] << (options[:message] || "is later than") % parse_date(options[:later_than])
    end
  end

  private

  def parse_date(date)
    return Date.today if date == :now
    date
  end
end

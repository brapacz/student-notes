class PaymentsDatatablePresenter
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  COLUMNS = %w[first_name last_name amount received_at].freeze

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      draw: params[:draw].to_i,
      recordsTotal: model.count,
      recordsFiltered: fetch_payments.count,
      data: data
    }
  end

  private

  def model
    Payment
  end

  def data
    payments.map do |payment|
      [
        (payment.student.first_name),
        (payment.student.last_name),
        number_to_currency(payment.amount),
        (payment.received_at.strftime("%Y-%m-%d")),
      ]
    end
  end

  def payments
    @payments ||= fetch_payments.offset(offset).limit(per_page)
  end

  def fetch_payments
    payments = model.order("#{sort_column} #{sort_direction}")
    payments = payments.joins(:student)
    if search_string.present?
      payments = payments.where("lower(first_name) like lower(:search) or lower(last_name) like lower(:search)", search: "%#{search_string}%")
    end
    payments
  end

  def search_string
    dig_param(:search, :value)
  end

  def offset
    params[:start].to_i
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    COLUMNS[dig_param(:order, 0, :column).to_i]
  end

  def sort_direction
    dig_param(:order, 0, :dir) == "desc" ? "desc" : "asc"
  end

  def dig_param(*path)
    value = params
    path.each do |key|
      value = (value || {})[key.to_s]
    end
    value
  end
end

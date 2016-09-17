class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: PaymentsDatatablePresenter.new(view_context) }
    end
  end
end

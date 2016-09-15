class PaymentsController < ApplicationController
  # expose(:students) { Student.all }
  # expose(:student_subject_items) { student.subject_items }

  # expose(:payment) { {id: 1} }
  # expose :payments

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: PaymentsDatatablePresenter.new(view_context) }
    end
  end

  # def create
  #   if student.save
  #     redirect_to student_path(student), notice: I18n.t('shared.created', resource: 'Student')
  #   else
  #     render :new
  #   end
  # end

  # def update
  #   if student.save
  #     redirect_to student_path(student), notice: I18n.t('shared.updated', resource: 'Student')
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   student.destroy
  #   redirect_to students_path, notice: I18n.t('shared.deleted', resource: 'Student')
  # end

  # private

  # def student_params
  #   params.require(:student).permit(:first_name, :last_name, :birthdate, subject_item_ids: [])
  # end
end

class AddTeacherIdToSubjectItems < ActiveRecord::Migration
  def change
    add_reference :subject_items, :teacher, index: true
  end
end

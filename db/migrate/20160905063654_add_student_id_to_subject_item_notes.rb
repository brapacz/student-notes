class AddStudentIdToSubjectItemNotes < ActiveRecord::Migration
  def change
    add_reference :subject_item_notes, :student, index: true
    # add_reference :subject_item_notes, :subject_item, index: true
  end
end

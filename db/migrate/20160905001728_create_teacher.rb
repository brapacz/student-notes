class CreateTeacher < ActiveRecord::Migration
  def change
    create_table :teachers, force: :cascade do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "academic_title"
    end
  end
end

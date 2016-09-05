require 'rails_helper'

RSpec.describe Student do
  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.not_to validate_presence_of :birthdate }

    it 'allow past date' do
      subject.birthdate = (rand 1..9999).days.ago
      subject.validate
      expect(subject.errors[:birthdate]).to be_empty
    end

    it 'disallow future date' do
      subject.birthdate = (rand 1..9999).days.from_now
      subject.validate
      expect(subject.errors[:birthdate]).to be_any
    end
  end

  describe 'database columns' do
    it { should have_db_column :first_name }
    it { should have_db_column :last_name }
    it { should have_db_column :birthdate }
  end

  describe 'associations' do
    it { is_expected.to have_many :subject_items }
    it { is_expected.to have_many :subject_item_notes }
    it { is_expected.to have_many :participations }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for :subject_items }
  end
end

FactoryGirl.define do
  factory :payment do
    student
    received_at { rand(1..200).days.ago }
    amount      { rand(1..999).days.ago }
  end
end

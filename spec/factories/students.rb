FactoryGirl.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    transient { with_payments 0 }
    after(:create) do |student, evaluator|
      create_list(:payment, evaluator.with_payments, student: student)
    end
  end
end

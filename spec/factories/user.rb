FactoryGirl.define do
  factory :user, class: Hash do
    email: "email@example.com"
    password: "password"
  end
end

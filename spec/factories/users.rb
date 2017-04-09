FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email {Faker::Internet.unique.email}
    password 'foobar'
  end
end
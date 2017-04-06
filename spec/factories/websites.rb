FactoryGirl.define do
  factory :website do
    name { Faker::Name.name }
    url 'http://random.org'
    description 'Some random description'
    association :user, factory: :user
  end
end
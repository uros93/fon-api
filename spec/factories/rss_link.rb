FactoryGirl.define do
  factory :rss_link do
    name { Faker::Name.name }
    link "http://www.rts.rs/page/stories/sr/rss.html"
    description {Faker::Lorem.sentences(1)}
    association :website, factory: :website
  end
end
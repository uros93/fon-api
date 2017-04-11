FactoryGirl.define do
  factory :rss_link do
  	transient do
  		categories_count 5
  	end
    name { Faker::Name.name }
    link "http://www.rts.rs/page/stories/sr/rss.html"
    description {Faker::Lorem.sentences(1)}
    association :website, factory: :website

    factory :rss_link_with_categories do
    	after(:create) do |rss, evaluator|
	    	(0...evaluator.categories_count).each do |i|
	    		rss.categories << FactoryGirl.create(:category)
	    	end
	    end
    end
  end
end
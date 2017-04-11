FactoryGirl.define do
  factory :category do
  	transient do
  		rss_links_count 5
  	end
    name { Faker::Team.name }
    association :user, factory: :user
    factory :category_with_links do
    	after(:create) do |category, evaluator|
    		(0...evaluator.rss_links_count).each do |i|
	    		category.rss_links << FactoryGirl.create(:rss_link)
	    	end
	    end
    end
  end
end
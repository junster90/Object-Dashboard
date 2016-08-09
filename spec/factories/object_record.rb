FactoryGirl.define do
  factory :object_record do
    add_attribute(:object_id) { 1 }
    object_type               { ["ObjectA", "ObjectB", "ObjectC"].sample }
    timestamp                 { Time.now.to_i }
    object_changes            { {property1: "some value", property2: "other value"} }

    trait :type_a do
      object_type "ObjectA"
    end

    trait :type_b do
      object_type "ObjectB"
    end

    trait :old do
      timestamp { 2.months.ago.to_i }
      object_changes { {property1: "1st value", property2: "1st value"} }
    end

    trait :middle do
      timestamp { 1.months.ago.to_i }
      object_changes { {property2: "2nd value"} }
    end

    trait :new do
      timestamp { 2.weeks.ago.to_i }
      object_changes { {property1: "2nd value", property3: "1st value"} }
    end

    factory :first_record, traits: [:type_a, :old]
    factory :second_record, traits: [:type_a, :middle]
    factory :last_record, traits: [:type_a, :new]

    factory :existing_record do
      add_attribute(:object_id) { 1 }
      object_type               { "ObjectA" }
      timestamp                 { 412351252 }
      object_changes            { {property1: "“value1\"", property3: "value2"} }
    end
  end
end

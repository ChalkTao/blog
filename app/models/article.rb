class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :content, type: String
  field :visit_count, type: Integer, default: 0

  has_and_belongs_to_many :labels, counter_cache: true

end

class Label
  include Mongoid::Document
  field :name, type: String
  field :articles_count, type: Integer

  has_and_belongs_to_many :articles, counter_cache: true
  validates :name, presence: true
end

class Label
  include Mongoid::Document
  field :name, type: String
  field :articles_count, type: Integer

  has_many :articles
  validates :name, presence: true
end

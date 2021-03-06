class Label
  include Mongoid::Document
  field :name, type: String
  field :articles_count, type: Fixnum

  has_and_belongs_to_many :articles
  validates :name, presence: true
end

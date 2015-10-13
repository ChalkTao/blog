class Label
  include Mongoid::Document
  field :name, type: String

  has_and_belongs_to_many :articles
  validates :name, presence: true
end

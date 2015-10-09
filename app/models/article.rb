class Article
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :visit_count, type: Integer
end

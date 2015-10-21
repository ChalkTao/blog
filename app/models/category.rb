class Category
  include Mongoid::Document
  field :name, type: String
  field :article_count, type: Integer, default: 0

  def addArticle
    self.article_count += 1
    self.save
  end
end

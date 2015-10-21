class Category
  include Mongoid::Document
  field :name, type: String
  field :article_count, type: Integer, default: 0

  def update_count(count)
    self.article_count += count
    self.article_count = 0 if self.article_count < 0
    self.save
  end
end

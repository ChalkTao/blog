class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :visit_count, type: Integer, default: 0

  has_and_belongs_to_many :labels

  def labels_content( need_blank=false )
    content = self.labels.collect { |label| label.name }.join(", ")
    content = I18n.t('none') if content.blank? and !need_blank
    content
  end

  def visited
    self.visit_count += 1
    self.save
    self.visit_count
  end

end

class News
  include Mongoid::Document
  include Mongoid::Timestamps
  field :header, type: String
  field :annotation, type: String
  field :expired_at, type: DateTime
  field :authored_item, type: Boolean, default: false
  field :date, type: DateTime

  before_validation :set_date
  after_save :update_views

  validates_presence_of :header, :annotation, :expired_at, :date

  scope :recent, -> { where('expired_at' => {'$gt' => Time.now.utc}).order_by(created_at: :desc) }

  def self.authored
    where(authored_item: true).recent.first
  end

  def self.from_yandex
    where(authored_item: false).recent.first
  end

  def set_date
    self.date = Time.now if authored_item == true
  end

  def update_views
    actual_news = News.authored || News.from_yandex
    attrs = {
      header: actual_news.header,
      annotation: actual_news.annotation.html_safe,
      date: actual_news.date.to_date
    }
    ActionCable.server.broadcast 'news_channel', attrs
  end
end

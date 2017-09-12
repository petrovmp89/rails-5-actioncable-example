class News
  include Mongoid::Document
  include Mongoid::Timestamps
  field :header, type: String
  field :annotation, type: String
  field :expired_at, type: DateTime
  field :authored_item, type: Boolean
  field :date, type: DateTime

  before_validation :set_date

  validates_presence_of :header, :annotation, :expired_at, :date

  def self.main_authored_item
    where(authored_item: true).where({'expired_at' => {'$gt' => Time.now.utc}}).order_by(created_at: :asc).last
  end

  def set_date
    self.date = Time.now if authored_item == true
  end
end

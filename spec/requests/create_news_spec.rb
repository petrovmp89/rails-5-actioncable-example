require 'rails_helper'

RSpec.describe "News", type: :request do
  it "displays existing created active news" do
    news_item = News.create!(header: 'TestHeader',
                        annotation: 'TestAnnotation',
                        expired_at: Time.now + 10.minutes,
                        date: Time.now)
    get "/"
    assert_select "#header", text: news_item.header
    assert_select "#annotation", text: news_item.annotation
  end
end

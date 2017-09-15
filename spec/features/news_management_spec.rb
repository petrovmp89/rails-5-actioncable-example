require "rails_helper"

RSpec.feature "News management", type: :feature do
  scenario "User creates news" do
    visit "/admin"
    fill_in "Header", with: "My news"
    fill_in "Annotation", with: "My news text"
    fill_in "Expired at", with: Time.now + 10.minutes
    click_button "Create News"
    expect(page).to have_text("News item was successfully created.")

    visit "/"
    expect(page).to have_text("My news")
    expect(page).to have_text("My news text")
    expect(page).to have_text((Time.now).to_date)
  end

  scenario "Getting yandex news" do
    body = '<?xml version="1.0" encoding="utf-8"?>
    <rss version="2.0">
      <channel>
        <title>Яндекс.Новости: Главное</title>
        <link>https://news.yandex.ru/index.html?from=rss</link>
        <description>
          Первая в России служба автоматической обработки и систематизации новостей. Сообщения ведущих российских и мировых СМИ. Обновление в режиме реального времени 24 часа в сутки.
        </description>
        <image>
          <url>https://company.yandex.ru/i/50x23.gif</url>
          <link>https://news.yandex.ru/index.html?from=rss</link>
          <title>Яндекс.Новости: Главное</title>
        </image>
        <lastBuildDate>15 Sep 2017 09:52:31 +0300</lastBuildDate>
        <item>
          <title>Парковка у посольства США в Москве стала общедоступной</title>
          <link>https://news.yandex.ru/yandsearch?cl4url=russian.rt.com%2Frussia%2Fnews%2F430306-parkovka-posolstvo-ssha-moskva&amp;from=rss</link>
          <description>Парковка у посольства США в Москве стала доступной для всех из-за нехватки парковочных мест.</description>
          <pubDate>15 Sep 2017 09:29:23 +0300</pubDate>
          <guid>https://news.yandex.ru/yandsearch?cl4url=russian.rt.com%2Frussia%2Fnews%2F430306-parkovka-posolstvo-ssha-moskva&amp;from=rss</guid>
        </item>
        <item>
          <title>Налог для AliExpress, Amazon и eBay могут ввести в России</title>
          <link>https://news.yandex.ru/yandsearch?cl4url=iz.ru%2F645933%2F2017-09-15%2Fnalog-dlia-aliexpress-amazon-i-ebay-mogut-vvesti-v-rossii&amp;from=rss</link>
          <description>Российской правительство рассмотрит проект поправок в Налоговый кодекс и закон «Об информации», которые обязывают иностранных ритейлеров, в число которых входят такие популярные компании, как AliExpress, Amazon и eBay, платить НДС по принципу «налога на Google».</description>
          <pubDate>15 Sep 2017 08:00:48 +0300</pubDate>
          <guid>https://news.yandex.ru/yandsearch?cl4url=iz.ru%2F645933%2F2017-09-15%2Fnalog-dlia-aliexpress-amazon-i-ebay-mogut-vvesti-v-rossii&amp;from=rss</guid>
        </item>
      </channel>
    </rss>'
    stub_request(:get, "https://news.yandex.ru/index.rss").
      to_return(status: 200, body: body)

    service = YandexNews.new
    service.perform
    visit "/"
    expect(page).to have_text("Парковка у посольства США в Москве стала общедоступной")
    expect(page).to have_text("Парковка у посольства США в Москве стала доступной для всех из-за нехватки парковочных мест.")
    expect(page).to have_text(Time.parse('15 Sep 2017 09:29:23 +0300').to_date)
  end
end

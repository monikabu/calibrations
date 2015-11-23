class QuotesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render text: quote["quote"]
  end

  private

  def quote
    response = RestClient::Request.execute(
      method: :post,
      url: "https://andruxnet-random-famous-quotes.p.mashape.com/cat=movies",
      headers: {
        "X-Mashape-Key" => ENV["MASHAPE_APP_KEY"],
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "application/json"
      })
    JSON.parse(response.body)
  end
end

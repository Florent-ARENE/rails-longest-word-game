class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @new_letters = params[:letters].upcase.split('')
    @new_score = params[:score].upcase.split('')
    word = @new_score & @new_letters
    dictionary = dico_word(word)
    @result = if word.empty?
                "Sorry but <strong>#{@new_score.join}</strong> can't be built out of #{@new_letters.join(', ')}"
              elsif dictionary['found']
                "<strong>Congratulations!</strong> #{word.join} is a valid Englis word."
              else
                "Sorry but <strong>#{word.join}</strong> does not seem to be a valid English word..."
              end.html_safe
  end

  def dico_word(word)
    words = word.join.downcase
    url = "https://wagon-dictionary.herokuapp.com/#{words}"
    JSON.parse(URI.open(url).read)
  end
end

require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    session[:score] ||= 0
    session[:words] ||= []
    if word_valid(params[:letters], params[:longest_word]) && english_word(params[:longest_word])
      @result = "Congratulations, '#{params[:longest_word]}' is a good word!"
      get_score()
    elsif word_valid(params[:letters], params[:longest_word])
      @result = "Sorry but '#{params[:longest_word]}' isn't English!"
    else
      @result = "Sorry but '#{params[:longest_word]}' can't be built from these letters!"
    end
  end

  private

  def word_valid(letters, word)
    letters = letters.split.select do |l|
      if word.upcase.include?(l)
        l
      end
    end
    letters.uniq.sort == word.upcase.split("").uniq.sort
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    api_serialized = open(url).read
    api = JSON.parse(api_serialized)

    api["found"]
  end

  def get_score
    session[:score] ||= 0
    # session[:score] = params[:longest_word].length : session[:score] += params[:longest_word].length
    session[:score] += params[:longest_word].length
    session[:words] ||= []
     # session[:words] = [params[:longest_word]] : session[:words] << params[:longest_word]
    session[:words] << params[:longest_word]
  end
end

require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score
    @guess = params[:word]
    @letters = params[:grid]
    if english_word?(@guess) == true
      if included?(@guess, @letters)
        @result = 'Congrats!'
      else
        @result = 'Try again!'
      end
    else
      @result = 'Try again'
    end
  end
end

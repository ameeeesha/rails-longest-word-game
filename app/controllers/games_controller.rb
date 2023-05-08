require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_dictionary = URI.open(url)
    word = JSON.parse(word_dictionary.read)
    word['found']
  end

  def new
    # used to display a new random grid and a form
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
    @letters
  end

  def letter_check
    @word.upcase.split(//).all? { |letter| @letters.split(' ').include?(letter) }
  end

  def score
    # the form will be submitted (with POST) to the score action
    # raise
    @letters = params[:letters]
    @word = params[:word]

    if @word.present?
      if letter_check && english_word?(@word)
        @answer = "Congratulations! #{@word} is a valid English word"
      elsif letter_check && !english_word?(@word)
        @answer = "sorry but #{@word} does not seem to be a valid English word..."
      else
        @answer = "Sorry but #{@word} can't be build out of the letters."
      end
    end
  end
end

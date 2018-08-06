require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    current_time = DateTime.now
    @array = params[:array].split(" ")
    @words = params[:user_input]
    if  @words.chars.all? { |letter| @words.count(letter) <= @array.count(letter) }
      @result = "It's not in the grid. Score is 0."
    elsif
      english_word?(@words) == false
      @result = "It's not English. Score is 0."
    else
      @result = "Your score is #{@words.length}"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end

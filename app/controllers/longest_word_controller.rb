require 'json'
require 'open-uri'

class LongestWordController < ApplicationController
  def game
    generate_grid
    flash[:time] = Time.now.to_f
  end

  def score
    @end_time = Time.now.to_f
    run_game
  end

  def generate_grid
    grid_size = 20
    @letters = []
    grid_size.times { @letters << ('A'..'Z').to_a.sample }
    flash[:letters] = @letters
  end

  def run_game
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @word = (params[:word] || '').upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

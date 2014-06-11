#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Teaser
  attr_accessor :teasers
  attr_accessor :tease


  def initialize(teasers=1)
    @teasers = teasers
    self.send('generate')
  end
 
#decides on a sentence to 'draw' from the 'deck' XD
    def deal()
        hand = @tease.pop(1)
        p hand
        if @tease.length() <= 5
           self.send('generate')
        end
        return hand.join(" ")
  end

  def generate()
    @tease = Array.new()
    @teasers.times { |i|
      ['teases', 'penetrates', 'rubs againt'].each do |choose|
#there are 7 sentences to generate from...update to 10 later.
          @tease << "#{choose}"
  end
    }
    @tease.shuffle!
    p @tease
  end
end
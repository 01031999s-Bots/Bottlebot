#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Teasa
  attr_accessor :teasas
  attr_accessor :teasa


  def initialize(teasas=1)
    @teasas = teasas
    self.send('generate')
  end
 
#decides on a sentence to 'draw' from the 'deck' XD
    def deal()
        hand = @teasa.pop(1)
        p hand
        if @teasa.length() <= 3
           self.send('generate')
        end
        return hand.join(" ")
  end

  def generate()
    @teasa = Array.new()
    @teasas.times { |i|
     ['with a dildo', 'with my tongue', 'with my finger', 'with a vibrator', 'with my penis'].each do |options|
          @teasa << "#{options}"
  end
    }
    @teasa.shuffle!
    p @teasa
  end
end
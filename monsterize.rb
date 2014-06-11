#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

class Monsterize
  attr_accessor :monsters
  attr_accessor :monsterize


  def initialize(monsters=1)
    @monsters = monsters
    self.send('generate')
  end
 
#decides on a sentence to 'draw' from the 'deck' XD
    def deal()
        hand = @monsterize.pop(1)
        p hand
        if @monsterize.length() <= 2
           self.send('generate')
        end
        return hand.join(" ")
  end

  def generate()
    @monsterize = Array.new()
    @monsters.times { |i|
      ['Charybdis http://monstergirlencyclopedia.wikia.com/wiki/Charybdis?file=Charybdis.jpg',
      'Charybdis http://monstergirlencyclopedia.wikia.com/wiki/Charybdis?file=Charybdis.jpg',
      'Goblin http://monstergirlencyclopedia.wikia.com/wiki/Goblin?file=Goblin.jpg',
      'Centaur http://monstergirlencyclopedia.wikia.com/wiki/Centaur?file=Centaur.PNG', 
      'Werewolf http://monstergirlencyclopedia.wikia.com/wiki/Werewolf?file=Werewolf.png', 
      'Angel http://monstergirlencyclopedia.wikia.com/wiki/Angel', 
      'Angel http://monstergirlencyclopedia.wikia.com/wiki/Angel', 
      'Angel http://monstergirlencyclopedia.wikia.com/wiki/Angel', 
      'Scylla http://monstergirlencyclopedia.wikia.com/wiki/Scylla?file=Scylla.PNG', #1
      'Zombie http://monstergirlencyclopedia.wikia.com/wiki/Zombie?file=Zombie.PNG', #2
      'Vampire',  #3
      ].each do |monsterize|
#there are 7 monsters with no pics.... Add more monsters and add pictures ASAP!
          @monsterize << "#{monsterize}"
      end
    }
    @monsterize.shuffle!
    p @monsterize
  end
end
#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'libfchat/fchat'
require 'yaml'
require 'logger'
require './deck.rb'
require './random.rb'
require './monsterize.rb'
require './tease.rb'
require './teasa'

class Bottlebot < Libfchat::Fchat
  attr_accessor :last_spun
  attr_accessor :current_player
  attr_accessor :deck
  attr_accessor :random
  attr_accessor :monsterize
  attr_accessor :tease
  attr_accessor :teasa
  
   # Respond to private messages
  def got_PRI(message)
    if message['message'] =~ /^join/
      room = message['message'].gsub(/^join/, '').strip
      self.JCH(room)
        self.PRI(message['character'], msg)
      elsif message['message'] =~ /^leave/
	      if message['character'] =~ /^Slave Sex Sure/
        room = message['message'].gsub(/^leave/, '').strip
        self.LCH(room)
      else
        msg = "I'm sorry, you're not allowed to ask me to leave that room"
        self.PRI(message['character'], msg)
	end
    else
      msg = "Bottlebot 1.2 by Jippen Faddoul ( http://github.com/jippen/fchat_bottlebot_ruby )"
      msg += "\nCommands:\n"
      msg += "\njoin <room> - Joins a chatroom (If private, /invite the bot instead)\n"
      msg += "leave <room> - Leaves a chatroom (If private, /invite the bot instead)"
      self.PRI(message['character'], msg)
      sleep(@msg_flood)
    end
  end
  

  # Respond to messages in chatrooms
  def got_MSG(message)
    @logger.info("got_MSG()")
    @logger.info("got_MSG() - #{message['message']}")
	if message['message'] =~ /^!roulette (.*)?/i
		msglist = message['message'].split(/roulette (.*)?/i)
		msg = "/me " + @random.deal() + " " + msglist[1] + "!"
	self.send('MSG',message['channel'],msg)
	elsif message['message'] =~ /^!roulette/
		msg = "/me " + @random.deal() + " " + message['character'] + "!"
	self.send('MSG',message['channel'],msg)
	elsif message['message'] =~ /^!slap ?/i
		msglist = message['message'].split(/slap ?/i)
		msg = "/me slaps " + msglist[1] + " around with a large penis!"
	self.send('MSG',message['channel'],msg)
	elsif message['message'].downcase =~ /^!rules/
	msg = "For drawing purposes- !deal
 
           Try to use your grammar and literacy. No kik su-n-us or ur turn.
 
           Have fun! This is a game meant to have fun! So try to show your teasing side a bit, okay? Unless you don't have fun doing that. Then... just show us something!
 
           Also, please be courteous and if your intentions are more than just teasing or flirting, take it to another room so as to not interrupt the flow of the game too much!
 
           Rule 1) Five pieces of clothing at a minimum. There is no SET maximum, but it's recommended not to go over eight pieces. One accessory is allowed per person.
 
           Rule 2) Once the dealer calls the winning hand ([b]PLEASE[/b] [u]refrain[/u] from calling a hand before the dealer! Help is appreciated in PMs, but it's confusing on occasion when someone other than the dealer calls the hands!) the person who wins picks one person to remove one piece of clothing.
 
           Rule 3) If it is the last piece of the person called, the one who called it removes it themselves. The naked person is then removed from play, to sit on the lap of the person who called them.
 
           Rule 4) The game continues until one person is left clothed. Good luck, and have fun.
           -------------
		Other commands
		--------------
		--------------
		!rules-Displays this message.
		!draw1-Draws 1 card.
		!draw2-Draws 2 cards.
		!draw3-Draws 3 cards.
		!monsterize- Turns you into a random [b][i][u]monstergirl[/u][/i][/b]	"
      self.PRI(message['character'], msg)
	elsif message['message'] =~ /^!deal (.*)? /
		msglist = message['message'].split(/deal (.*)?/)
		msg = msglist[1] + ": " + @deck.deal()
	self.send('MSG',message['channel'],msg)
	elsif message['message'] =~ /^!monsterize (.*)?/i
		msglist = message['message'].split(/monsterize (.*)?/i)
		msg = "/me shoots a beam of light at " + msglist[1] + " turning them into a " + @monsterize.deal() + " ."
	self.send('MSG',message['channel'],msg)
	elsif message['message'] =~ /^!monsterize/
	      msg ="/me shoots a beam of light at " + message['character'] + " turning them into a " + @monsterize.deal()
	self.send('MSG',message['channel'],msg)
	elsif message['message'] =~ /^!tease (.*)?/i
		msglist = message['message'].split(/tease (.*)?/i)
		msg = "/me " + @tease.deal() + " " + msglist[1] + " " + @teasa.deal() + "!"
	self.send('MSG',message['channel'],msg)
	elsif message['message'] =~ /^!tease/
	      msg = "/me " + @tease.deal() + " " + message['character'] + " " + @teasa.deal() + "!"
	self.send('MSG',message['channel'],msg)
	elsif message['message'] =~ /^!deal/
	      msg = message['character'] + ": " + @deck.deal()
	self.send('MSG',message['channel'],msg)
	elsif message['message'].downcase =~ /^!draw1/
	      msg = message['character'] + ": " + @deck.draw1()
	self.send('MSG',message['channel'],msg)
	elsif message['message'].downcase =~ /^!draw2/
	      msg = message['character'] + ": " + @deck.draw2()
	self.send('MSG',message['channel'],msg)
	elsif message['message'].downcase =~ /^!draw3/
	      msg = message['character'] + ": " + @deck.draw3()
	self.send('MSG',message['channel'],msg)
	elsif message['message'].downcase =~ /^!botstats/
		msg = "\nActive Commands:\n"
		msg += " roulette, draw 1-3, monsterize, & deal"
		msg += "\nBeta commands:\n"
		msg += "Give me some idea's, don't just stand there?"
	self.send('MSG',message['channel'],msg)
    self.fix_skiplist(message['channel'])
    @logger.info("got_MSG() - fix_skiplist()")
    self.remove_from_skip_list(message['channel'], message['character'])
    @logger.info("got_MSG() - remove_from_skip_list()")
    elsif message['message'] == '!skip'
      self.add_to_skip_list(message['channel'], message['character'])
    elsif message['message'] =~ /^!skip/
      person = message['message'].gsub(/^!skip/, '').strip
      self.add_to_skip_list(message['channel'], person)
    elsif message['message'] =~ /^!spin/
      @logger.info("got_MSG() - spinning the bottle")
      players = self.spin_list(message['channel'], message['character'])
      @logger.info("got_MSG() - players: #{players}")
      if players == []
        msg = "/me can't find anyone to play with!"
      else
        player = players.sample
        msg = "/me spins around, and eventually lands on [b]#{player}[/b]"
      end
      self.send('MSG',message['channel'],msg)
    else
      @logger.info("gotMSG() - parseFail")
        end
end

def remove_from_skip_list(channel, person)
    self.fix_skiplist(channel)
    @rooms[channel]['skiplist'].delete(person)
  end

  # Perform a case-insensitive search for a user in a room
  def search_for_character(channel, person)
    if @rooms[channel]['characters'].include? person
      return person
    else
      re = /\A#{Regexp.escape(person)}\z/i
      @rooms[channel]['characters'].each { |char|
        if char =~ re
          return char
        end
      }
    end
    return nil
  end

  def add_to_skip_list(channel, person)
    self.fix_skiplist(channel)
    person = self.search_for_character(channel, person)
    if person == nil
      return
    end

    @rooms[channel]['skiplist'] << person
    self.MSG(channel, "Now skipping: [b]#{person}[/b]")
  end

  def fix_skiplist(channel)
    if @rooms[channel]['skiplist'] == nil
      @rooms[channel]['skiplist'] = []
    end
  end

  def spin_list(channel, character)
    @logger.info("spin_list()")
    eligible = @rooms[channel]['characters']
    @logger.info("eligible - #{eligible}")
    self.fix_skiplist(channel)
    @logger.info("fix skip list")
    eligible.delete_if { |c| character_spinnable(channel, c) == false }
    eligible.delete(character)
    return eligible
  end

  def character_spinnable(channel, character)  
    fix_skiplist(channel)
    status = @users[character]['status']
    begin
      if ['busy', 'dnd', 'away'].include? status
        return false
      elsif character == @me
        return false
      elsif @rooms[channel]['skiplist'].include? character
        return false
      else
        return true
      end
    rescue
      return false
    end
  end
end

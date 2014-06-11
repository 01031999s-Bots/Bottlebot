#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
$:.push File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'yaml'
require 'logger'
require 'bottlebot'
require 'monitor'


bot = Bottlebot.new("Bottlebot by Jippen Faddoul ( http://github.com/jippen/fchat_bottlebot_ruby )","1.0")

config = YAML.load_file('config/fchat.yaml')


bot.deck = Deck.new()
bot.random = Random.new()
bot.monsterize = Monsterize.new()
bot.tease = Teaser.new()
bot.teasa = Teasa.new()

bot.login(config['server'],config['username'],config['password'],config['character'])

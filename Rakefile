# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rake'
require 'rspec/core/rake_task'
require 'libfchat/version'

task :default => :test

task :test => [:spec]

RSpec::Core::RakeTask.new do |t|
  t.ruby_opts = '-w'
  t.rspec_opts = '--color --format nested'
end

desc "build gem package"
task :run do
    sh 'ruby bin/bot.rb'
end
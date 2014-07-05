require 'sidekiq'

require_relative '../models/phrase'

class PhraseParser
  include Sidekiq::Worker
  
  def perform filename
    # Normally one would want to use some kind of batch uploader here to speed things up and avoid 
    # creating individual ActiveRecords alltogether.
    # But in our case deduplication of phrases makes that batching approach not that valuable
    File.new(filename).each_line '|' do |line|
      line = line.chop.strip
      begin
        Phrase.create(value: line)
      rescue ActiveRecord::RecordNotUnique
        puts "Phrase #{line} is already there"
      end
    end

    FileUtils.rm filename
  end
end
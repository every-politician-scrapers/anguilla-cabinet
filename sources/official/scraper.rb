#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
      raw.last.tidy
    end

    field :position do
      raw.first.gsub('Hon.', '').tidy
    end

    private

    def raw
      noko.attr('alt').tidy.split(' - ')
    end
  end

  class Members
    def member_container
      noko.css('.quickLinkCat img[@alt]')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv

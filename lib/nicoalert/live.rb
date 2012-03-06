# -*- coding: utf-8 -*-

require 'nokogiri'
require 'rest-client'

module Nicoalert
  class Live
    attr_reader :id, :community_id

    def initialize(id, community_id)
      @id = id
      @community_id = community_id
    end

    def title
      @title ||= info.css('streaminfo title').text
    end

    def description
      @description ||= info.css('streaminfo description').text
    end

    def provider_type
      @provider_type ||= info.css('streaminfo provider_type').text.to_sym
    end

    def uri
      @uri ||= "#{LIVE_URI}#@id"
    end

    def community_name
      @name ||= info.css('communityinfo name').text
    end

    def community_thumbnail
      @thumbnail ||= URI.parse(info.css('communityinfo thumbnail').text)
    end

    def community
      @community ||= Community.new(community_id, community_name, community_thumbnail)
    end

    private

    def info
      @info ||= Nokogiri::XML(RestClient.get("#{INFO_URI}#@id"))
    end

    INFO_URI = 'http://live.nicovideo.jp/api/getstreaminfo/lv'
    LIVE_URI = 'http://live.nicovideo.jp/watch/lv'

  end
end

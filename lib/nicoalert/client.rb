# -*- coding: utf-8 -*-

require 'rest-client'
require 'nokogiri'
require 'socket'

module Nicoalert
  class Client
    attr_reader :mail

    def initialize(mail, password)
      @mail = mail
      @password = password
    end

    def user_id
      @user_id ||= status.css('user_id').text
    end

    def user_hash
      @user_hash ||= status.css('user_hash').text
    end

    def addr
      @addr ||= status.css('ms addr').text
    end

    def port
      @port ||= status.css('ms port').text
    end

    def thread
      @thread ||= status.css('ms thread').text
    end

    def communities
      @communities ||= status.css('communities community_id').map(&:text)
    end

    def connect(&block)
      TCPSocket.open(addr, port) do |socket|
        socket <<
          %{<thread thread="#{thread}" version="20061206" res_from="-1" />\0}
        while line = socket.gets("\0")
          item = Nokogiri::XML.fragment(line.sub("\0", ''))
          next unless chat = item.css('chat')
          id, community, user = chat.text.split(',')
          next unless id && community && user
          block.call Live.new(id, community)
        end
      end
    end

    private

    def ticket
      unless @ticket
        login = Nokogiri::XML(
          RestClient.post(LOGIN_URI, mail: @mail, password: @password))
        @ticket = login.css('ticket').text
      end
      @ticket
    end

    def status
      @status ||= Nokogiri::XML(
        RestClient.get(STATUS_URI, params: { ticket: ticket }))
    end

    LOGIN_URI = 'https://secure.nicovideo.jp/secure/login?site=nicolive_antenna'
    STATUS_URI = 'http://live.nicovideo.jp/api/getalertstatus'
  end
end

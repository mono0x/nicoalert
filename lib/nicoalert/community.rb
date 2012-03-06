# -*- coding: utf-8 -*-

require 'uri'

module Nicoalert
  class Community
    attr_reader :id, :name, :thumbnail

    def initialize(id, name, thumbnail)
      @id = id
      @name = name
      @thumbnail = thumbnail
    end
  end
end

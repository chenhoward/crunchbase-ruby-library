# encoding: utf-8

module Crunchbase::Model
  class New < Crunchbase::Model::Entity

    RESOURCE_LIST = 'news'

    attr_reader :title, :author, :posted_on, :posted_on_trust_code, :url, :created_at, :updated_at, :type

    def property_keys
      %w[
        title author posted_on posted_on_trust_code url created_at updated_at type
      ]
    end

    def date_keys
      %w[posted_on]
    end

  end
end

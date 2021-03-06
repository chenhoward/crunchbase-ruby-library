# encoding: utf-8

module Crunchbase::Model
  class Investment < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'investments'

    attr_reader :money_invested, :money_invested_currency_code, :money_invested_usd, :created_at, :updated_at

    attr_reader :funding_round, :invested_in, :investors

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        instance_relationships_object(Crunchbase::Model::FundingRound, 'funding_round', relationships['funding_round'])

        if relationships['investors'].kind_of?(Array)
          instance_multi_relationships_object(Crunchbase::Model::Investor, 'investors', relationships['investors'])
        else
          instance_relationships_object(Crunchbase::Model::Investor, 'investors', relationships['investors'])
        end unless relationships['investors'].nil?
      end
    end

    def property_keys
      %w[
        money_invested money_invested_currency_code money_invested_usd created_at updated_at
      ]
    end

    private
    def instance_multi_relationships_object(object_name, key, items)
      multi_items = []

      items.each do |item|
        multi_items << object_name.new(item || nil)
      end

      instance_variable_set "@#{key}", multi_items
    end

  end
end
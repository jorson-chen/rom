# frozen_string_literal: true

require_relative "support/inflector"
require_relative "support/configurable"

module ROM
  extend Configurable

  # @api private
  module Settings
    Namespace = -> (args) { Array(args).flatten(1).uniq.join(".") }
  end

  # Defaults for all component types
  setting :component do
    setting :type
    setting :adapter
    setting :gateway, default: :default
    setting :inflector, default: Inflector
  end

  # Gateway defaults
  setting :gateway do
    setting :type, default: :gateway
    setting :id, default: :default
    setting :namespace, default: "gateways"
    setting :adapter
    setting :logger
    setting :args, default: EMPTY_ARRAY
    setting :opts, default: EMPTY_HASH
  end

  # Dataset defaults
  setting :dataset do
    setting :type, default: :dataset
    setting :abstract, default: true
    setting :id
    setting :namespace, default: "datasets"
    setting :adapter
    setting :gateway
  end

  # Schema defaults
  setting :schema do
    setting :type, default: :schema
    setting :id
    setting :namespace, default: "schemas"
    setting :as
    setting :relation
    setting :adapter
    setting :gateway
    setting :view, default: false
    setting :infer, default: false
    setting :constant
    setting :dsl_class
    setting :attr_class
    setting :inferrer
  end

  # Relation defaults
  setting :relation do
    setting :type, default: :relation
    setting :abstract, default: true
    setting :id
    setting :namespace, default: "relations"
    setting :dataset
    setting :adapter
    setting :inflector
    setting :gateway
  end

  # Association defaults
  setting :association do
    setting :type, default: :association
    setting :id
    setting :namespace, default: "associations"
    setting :inflector
    setting :adapter
    setting :as
    setting :name
    setting :relation
    setting :source
    setting :target
    setting :foreign_key
    setting :result
    setting :view
    setting :override
    setting :combine_keys
  end

  # Command defaults
  setting :command do
    setting :inherit do
      setting :paths, default: EMPTY_ARRAY
      setting :compose, default: %i[namespace]
    end
    setting :type, default: :command
    setting :id
    setting :namespace, default: "commands", constructor: Settings::Namespace
    setting :relation
    setting :adapter
    setting :gateway
  end

  # Command defaults
  setting :mapper do
    setting :inherit do
      setting :paths, default: EMPTY_ARRAY
      setting :compose, default: %i[namespace]
    end
    setting :type, default: :mapper
    setting :id
    setting :namespace, default: "mappers", constructor: Settings::Namespace
    setting :relation
    setting :adapter
  end

  # @api private
  def self.settings
    _settings
  end
end

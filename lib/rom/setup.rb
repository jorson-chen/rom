require 'rom/setup/finalize'

module ROM
  # Exposes DSL for defining relations, mappers and commands
  #
  # @public
  class Setup
    include Equalizer.new(:repositories, :env)

    # @api private
    attr_reader :repositories, :default_adapter,
      :relation_classes, :mapper_classes, :command_classes, :env

    # @api private
    def initialize(repositories, default_adapter = nil)
      @repositories = repositories
      @default_adapter = default_adapter
      @relation_classes = []
      @mapper_classes = []
      @command_classes = []
      @env = nil
    end

    # Finalize the setup
    #
    # @return [Env] frozen env with access to repositories, relations,
    #                mappers and commands
    #
    # @api public
    def finalize
      raise EnvAlreadyFinalizedError if env
      finalize = Finalize.new(
        repositories, relation_classes, mapper_classes, command_classes
      )
      @env = finalize.run!
    end

    # Returns repository identified by name
    #
    # @return [Repository]
    #
    # @api private
    def [](name)
      repositories.fetch(name)
    end

    # @api private
    def register_relation(klass)
      @relation_classes << klass
    end

    # @api private
    def register_mapper(klass)
      @mapper_classes << klass
    end

    # @api private
    def register_command(klass)
      @command_classes << klass
    end

    # Hook for respond_to? used internally
    #
    # @api private
    def respond_to_missing?(name, _include_context = false)
      repositories.key?(name)
    end

    private

    # Returns repository if method is a name of a registered repository
    #
    # @return [Repository]
    #
    # @api private
    def method_missing(name, *)
      repositories.fetch(name) { super }
    end
  end
end

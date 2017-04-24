module CSVImporter
  # The configuration of a CSVImporter
  class Config
    include Virtus.model

    attribute :model
    attribute :column_definitions, Array[ColumnDefinition], default: proc { [] }
    attribute :identifiers, Array[Symbol], default: []
    attribute :when_invalid, Symbol, default: proc { :skip }
    attribute :after_build_blocks, Array[Proc], default: []
    attribute :after_save_blocks, Array[Proc], default: []
    attribute :after_error_blocks, Array[Proc], default: []
    attribute :after_complete_blocks, Array[Proc], default: []

    def initialize_copy(orig)
      super
      self.column_definitions = orig.column_definitions.dup
      self.identifiers = orig.identifiers.dup
      self.after_build_blocks = orig.after_build_blocks.dup
      self.after_save_blocks = orig.after_save_blocks.dup
      self.after_error_blocks = orig.after_error_blocks.dup
      self.after_complete_blocks = orig.after_complete_blocks.dup
    end

    def after_build(block)
      self.after_build_blocks << block
    end

    def after_save(block)
      self.after_save_blocks << block
    end

    def after_error(block)
      self.after_error_blocks << block
    end

    def after_complete(block)
      self.after_complete_blocks << block
    end
  end
end


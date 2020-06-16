# frozen_string_literal: true

module RuboCop # :nodoc:
  module Cop # :nodoc:
    module Packaging # :nodoc:
      # TODO
      # Help from cop/lint/redundant_require_statement.rb
      class RequireRelativeToLib < Cop
        # TODO
        MSG = 'Avoid using `require` with relative path to lib.'

        def_node_matcher :require_relative?, <<~PATTERN
          (send nil? :require_relative
            (str {#starts_with_require_relative?}))
        PATTERN

        def on_send(node)
          return unless require_relative?(node)

          add_offense(node)
        end

        def starts_with_require_relative?(str)
          str.start_with?('lib')
        end
      end
    end
  end
end

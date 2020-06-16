# frozen_string_literal: true

module RuboCop # :nodoc:
  module Cop # :nodoc:
    module Packaging # :nodoc:
      # TODO
      # Help from cop/lint/redundant_require_statement.rb
      class RelativeRequireToLib < Cop
        # TODO
        MSG = 'Avoid using `require` with relative path to lib.'

        def_node_matcher :require?, <<~PATTERN
          (send nil? :require
            (str {#starts_with_relative_path?}))
        PATTERN

        def on_send(node)
          return unless require?(node)

          add_offense(node)
        end

        def starts_with_relative_path?(str)
          str.start_with?('../../lib')
        end
      end
    end
  end
end

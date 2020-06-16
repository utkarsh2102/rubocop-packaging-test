# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Packaging::RequireRelativeToLib do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  let(:message) { RuboCop::Cop::Packaging::RequireRelativeToLib::MSG }

  it 'registers an offense when using `require_relative` to lib/whatever/file' do
    expect_offense(<<~RUBY)
      require_relative 'lib/whatever/file'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
    RUBY
  end

  it 'registers an offense when using `require_relative` to lib/whatever' do
    expect_offense(<<~RUBY)
      require_relative 'lib/whatever'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{message}
    RUBY
  end

  it 'registers an offense when using `require_relative` to lib' do
    expect_offense(<<~RUBY)
      require_relative 'lib'
      ^^^^^^^^^^^^^^^^^^^^^^ #{message}
    RUBY
  end

  it 'does not register an offense when using `require_relative` to spec/whatever' do
    expect_no_offenses(<<~RUBY)
      require_relative 'spec/whatever'
    RUBY
  end

  it 'does not register an offense when using `require_relative` to spec_helper' do
    expect_no_offenses(<<~RUBY)
      require_relative 'spec_helper'
    RUBY
  end
end

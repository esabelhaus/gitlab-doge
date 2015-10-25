require "attr_extras"
require "rubocop"
require "sentry-raven"

require "fast_spec_helper"
require "app/models/default_config_file"
require "app/models/style_guide/base"
require "app/models/style_guide/ruby"
require "app/models/violation"

describe StyleGuide::Ruby, "#violations_in_file" do
  include ConfigurationHelper

  context "with default configuration" do
    describe "for { and } as %r literal delimiters" do
      it "returns no violations" do
        expect(violations_in(<<-CODE)).to eq []
'test' =~ %r{/t/e/s/t/test/}
        CODE
      end
    end

    describe "for private prefix" do
      it "returns no violations" do
        expect(violations_in(<<-CODE)).to eq []
private def foo
  bar
end
        CODE
      end
    end

    describe "for trailing commas" do
      it "returns violations" do
        violations = [
          "Avoid comma after the last item of an array.",
          "Avoid comma after the last parameter of a method call.",
          "Avoid comma after the last item of a hash."
        ]

        expect(violations_in(<<-CODE)).to eq violations
_one = [
  1,
]
_two(
  1,
)
_three = {
  one: 1,
}
        CODE
      end
    end

    describe "for single line conditional" do
      it "returns violations" do
        violations = [
          "Favor modifier `if` usage when having a single-line body. Another good alternative is the usage of control flow `&&`/`||`.",
          "Favor modifier `while` usage when having a single-line body."
        ]

        expect(violations_in(<<-CODE)).to eq violations
if signed_in? then redirect_to dashboard_path end

while signed_in? do something end
        CODE
      end
    end

    describe "for has_* method name" do
      it "returns no violations" do
        expect(violations_in(<<-CODE)).to eq []
def something?
  'something'
end
        CODE
      end
    end

    describe "for is_* method name" do
      it "returns violations" do
        violations = [
          "Rename `is_something?` to `something?`.",
          "Prefer single-quoted strings when you don't need string interpolation or special symbols."
        ]

        expect(violations_in(<<-CODE)).to eq violations
def is_something?
  "something"
end
        CODE
      end
    end

    describe "when using detect" do
      it "returns no violations" do
        expect(violations_in(<<-CODE)).to eq []
users.detect(&:active?)
        CODE
      end
    end

    describe "when using select" do
      it "returns no violations" do
        expect(violations_in(<<-CODE)).to eq []
users.select(&:active?)
        CODE
      end
    end

    describe "when using inject" do
      it "returns no violations" do
        expect(violations_in(<<-CODE)).to eq []
users.inject(0) do |sum, user|
  sum + user.age
end
        CODE
      end
    end

    context "for long line" do
      it "returns violation" do
        violations = ["Line is too long. [81/80]"]

        expect(violations_in("a" * 81 + "\n")).to eq violations
      end
    end

    context "for trailing whitespace" do
      it "returns violation" do
        violations = ["Trailing whitespace detected."]

        expect(violations_in("[1, 2].sum \n")).to eq violations
      end
    end

    context "for spaces after (" do
      it "returns violations" do
        violations = ["Space inside parentheses detected."]

        expect(violations_in(<<-CODE)).to eq violations
logger( 'test')
        CODE
      end
    end

    context "for spaces before )" do
      it "returns violations" do
        violations = ["Space inside parentheses detected."]

        expect(violations_in(<<-CODE)).to eq violations
logger('test' )
        CODE
      end
    end

    context "for spaces before ]" do
      it "returns violations" do
        violations = [
          "Space inside square brackets detected.",
          "Prefer single-quoted strings when you don't need string interpolation or special symbols."
        ]
        expect(violations_in(<<-CODE)).to eq violations
a["test" ]
        CODE
      end
    end

    context "for private methods indented more than public methods" do
      it "returns violations" do
        violations = ["Inconsistent indentation detected."]

        expect(violations_in(<<-CODE)).to eq violations
def one
  1
end

private

  def two
    2
  end
        CODE
      end
    end

    context "for tab indentation" do
      it "returns violations" do
        violations = [
          "Use 2 (not 1) spaces for indentation.",
          "Prefer single-quoted strings when you don't need string interpolation or special symbols.",
          "Tab detected."
        ]

        expect(violations_in(<<-CODE)).to eq violations
def test
\tlogger "test"
end
        CODE
      end
    end

    context "for two methods without newline separation" do
      it "returns violations" do
        violations = ["Use empty lines between method definitions."]

        expect(violations_in(<<-CODE)).to eq violations
def one
  1
end
def two
  2
end
        CODE
      end
    end

    context "for operator without surrounding spaces" do
      it "returns violations" do
        violations = ["Surrounding space missing for operator `+`."]
        expect(violations_in(<<-CODE)).to eq violations
1+1
        CODE
      end
    end

    context "for comma without trailing space" do
      it "returns violations" do
        violations = ["Space missing after comma."]

        expect(violations_in(<<-CODE)).to eq violations
logger :one,:two
        CODE
      end
    end

    context "for colon without trailing space" do
      it "returns violations" do
        violations = ["Space missing after colon.",
                      "Space inside { missing.",
                      "Space inside } missing."]

        expect(violations_in(<<-CODE)).to eq violations
{one:1}
        CODE
      end
    end

    context "for semicolon without trailing space" do
      it "returns violations" do
        violations = ["Do not use semicolons to terminate expressions.",
                      "Space missing after semicolon."]

        expect(violations_in(<<-CODE)).to eq violations
logger :one;logger :two
        CODE
      end
    end

    context "for opening brace without leading space" do
      it "returns violations" do
        violations = ["Surrounding space missing for operator `=`."]

        expect(violations_in(<<-CODE)).to eq violations
a ={ one: 1 }
a
        CODE
      end
    end

    context "for opening brace without trailing space" do
      it "returns violations" do
        violations = ["Space inside { missing."]

        expect(violations_in(<<-CODE)).to eq violations
a = {one: 1 }
a
        CODE
      end
    end

    context "for closing brace without leading space" do
      it "returns violations" do
        violations = ["Space inside } missing."]

        expect(violations_in(<<-CODE)).to eq violations
a = { one: 1}
a
        CODE
      end
    end

    context "for method definitions with optional named arguments" do
      it "does not return violations" do
        expect(violations_in(<<-CODE)).to be_empty
def register_email(email:)
  register(email)
end
        CODE
      end
    end

    context "for argument list spanning multiple lines" do
      context "when each argument is not on its own line" do
        it "returns violations" do
          code = <<-CODE.strip_heredoc
            validates :name,
              presence: true,
              uniqueness: true
          CODE

          expect(violations_in(code)).to eq [
            "Align the parameters of a method call if they span more than " +
              "one line."
          ]
        end
      end

      context "when each argument is on its own line" do
        it "returns no violations" do
          code = <<-CODE.strip_heredoc
            validates(
              :name,
              presence: true,
              uniqueness: true
            )
          CODE

          expect(violations_in(code)).to be_empty
        end
      end
    end

    context "for required keyword arguments" do
      context "without space after arguments" do
        it "returns no violations" do
          code = <<-CODE.strip_heredoc
            def initialize(name:, age:)
              @name = name
              @age = age
            end
          CODE

          expect(violations_in(code)).to be_empty
        end
      end

      context "with spaces after arguments" do
        it "returns violations" do
          code = <<-CODE.strip_heredoc
            def initialize(name: , age: )
              @name = name
              @age = age
            end
          CODE

          violations = violations_in(code)

          expect(violations).to eq [
            "Space found before comma.",
            "Space inside parentheses detected.",
          ]
        end
      end
    end
  end

  context "with custom configuration" do
    it "finds only one violation" do
      config = {
        "StringLiterals" => {
          "EnforcedStyle" => "double_quotes"
        }
      }

      violations = violations_with_config(config)

      expect(violations).to eq ["Use the new Ruby 1.9 hash syntax."]
    end

    it "can use custom configuration to show rubocop cop names" do
      config = { "ShowCopNames" => "true" }

      violations = violations_with_config(config)

      expect(violations).to eq [
        "Style/HashSyntax: Use the new Ruby 1.9 hash syntax.",
        "Style/StringLiterals: Prefer single-quoted strings when you don't need string interpolation or special symbols."
      ]
    end

    context "with old-style syntax" do
      it "has one violation" do
        config = {
          "StringLiterals" => {
            "EnforcedStyle" => "single_quotes"
          },
          "HashSyntax" => {
            "EnforcedStyle" => "hash_rockets"
          },
        }

        violations = violations_with_config(config)

        expect(violations).to eq [
          "Prefer single-quoted strings when you don't need string "\
          "interpolation or special symbols."
        ]
      end
    end

    context "with excluded files" do
      it "has no violations" do
        config = {
          "AllCops" => {
            "Exclude" => ["lib/a.rb"]
          }
        }

        violations = violations_with_config(config)

        expect(violations).to be_empty
      end

      it 'allows a cop to be excluded for specific files or directories' do
        config = {
          "StringLiterals" => {
            "EnforcedStyle" => "single_quotes"
          },
          "HashSyntax" => {
            "Exclude" => ["lib/**/*"]
          }
        }

        violations = violations_with_config(config)

        expect(violations).to eq [
          "Use the new Ruby 1.9 hash syntax.",
          "Prefer single-quoted strings when you don't need string "\
          "interpolation or special symbols."
        ]
      end
    end

    context "with using block" do
      it "returns violations" do
        violations = ["Pass `&:name` as an argument to `map` "\
                      "instead of a block."]

        expect(violations_in(<<-CODE)).to eq violations
users.map do |user|
  user.name
end
        CODE
      end
    end

    context "with calls debugger" do
      it "returns violations" do
        violations = ["Remove debugger entry point `binding.pry`."]

        expect(violations_in(<<-CODE)).to eq violations
binding.pry
        CODE
      end
    end

    context "with empty lines around block" do
      it "returns violations" do
        violations = ["Extra empty line detected at block body beginning.",
                      "Extra empty line detected at block body end."]

        expect(violations_in(<<-CODE)).to eq violations
block do |hoge|

  hoge

end
        CODE
      end
    end

    def violations_with_config(config)
      content = <<-TEXT.strip_heredoc
        def test_method
          { :foo => "hello world" }
        end
      TEXT

      violations_in(content, config: config)
    end
  end

  context "default configuration" do
    it "uses a default configuration for rubocop" do
      spy_on_rubocop_team
      spy_on_rubocop_configuration_loader
      config_file = default_configuration_file(StyleGuide::Ruby)
      code = <<-CODE
        private def foo
          bar
        end
      CODE

      violations_in(code)

      expect(RuboCop::ConfigLoader).to have_received(:configuration_from_file).
        with(config_file)

      expect(RuboCop::Cop::Team).to have_received(:new).
        with(anything, default_configuration, anything)
    end
  end

  private

  def violations_in(content, config: nil)
    repo_config = double("RepoConfig", enabled_for?: true, for: config)
    style_guide = StyleGuide::Ruby.new(repo_config)
    style_guide.violations_in_file(build_file(content)).flat_map(&:messages)
  end

  def build_file(content)
    line = double("Line", content: "blah", number: 1, patch_position: 2)
    double("CommitFile", content: content, filename: "lib/a.rb", line_at: line)
  end

  def default_configuration
    config_file = default_configuration_file(StyleGuide::Ruby)
    RuboCop::ConfigLoader.configuration_from_file(config_file)
  end

  def spy_on_rubocop_team
    allow(RuboCop::Cop::Team).to receive(:new).and_call_original
  end

  def spy_on_rubocop_configuration_loader
    allow(RuboCop::ConfigLoader).to receive(:configuration_from_file).
      and_call_original
  end
end

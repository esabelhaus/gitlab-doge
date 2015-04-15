require "fast_spec_helper"
require "jlint"
require "app/models/default_config_file"
require "app/models/violation"
require "app/models/style_guide/base"
require "app/models/style_guide/java"

describe StyleGuide::Java do
  include ConfigurationHelper
  context "with default configuration" do
    describe "when errors are found in java" do
      it "returns a set of violations" do
        sample_errors = ["Missing a Javadoc comment.",
                         "Missing a Javadoc comment.",
                         "Method Name 'Sample' must not equal the enclosing class name.",
                         "Name 'Sample' must match pattern '^[a-z][a-zA-Z0-9]*$'.",
                         "Method 'hi' is not designed for extension - needs to be abstract, final or empty.",
                         "Missing a Javadoc comment.",
                         "Parameter name should be final."]
        expect(violations_in(<<-CODE)).to eq sample_errors
          public class Sample {
            public static void Sample() {
            }

            public void hi(long name) {
              system.out.printf("Hi, " + name);
            }
          }
        CODE
      end
    end

    describe "when no errors are found in java" do
      it "returns no violations" do
        expect(violations_in(<<-CODE)).to eq []
          /**
          * @author      Doge
          * @version     1.3.37
          * @since       2015-04-03
          */
          public class Sample {

            /**
            * private string.
            */
            private String foo;

            /**
            * constructor.
            * @param bar string to set foo
            */
            Sample(final String bar) {
              self.foo = bar;
            }

          }
        CODE
      end
    end
  end

  context "when a custom config is provided" do
    describe "checking for star import" do
      it "should detect violations in code" do
        config = %Q[<?xml version="1.0"?>
<!DOCTYPE module PUBLIC
          "-//Puppy Crawl//DTD Check Configuration 1.3//EN"
          "http://www.puppycrawl.com/dtds/configuration_1_3.dtd">
<module name="Checker">
  <module name="TreeWalker">
    <module name="AvoidStarImport"/>
  </module>
</module>]

        violations = violations_with_config(config)

        expect(violations).to eq [
          "Using the '.*' form of import should be avoided - java.util.*."
        ]
      end
    end

    describe "an improper config is provided" do
      it "should throw an error" do
        config = %Q[<?xml version="1.0"?>
<!DOCTYPE module PUBLIC
          "-//Puppy Crawl//DTD Check Configuration 1.3//EN"
          "http://www.puppycrawl.com/dtds/configuration_1_3.dtd">
<module name="Checker">
  <module name="AvoidStarImport"/>
</module>]

        content = <<-TEXT.strip_heredoc
          import java.util.*;
          public class Sample {
            public static void Sample() {
            }

            public void hi(long name) {
              system.out.printf("Hi, " + name);
            }
          }
        TEXT

        repo_config = double("RepoConfig", enabled_for?: true, for: config)
        style_guide = StyleGuide::Java.new(repo_config)

        expect{style_guide.violations_in_file(build_file(content)).flat_map(&:messages)}.to raise_error(RuntimeError)
      end
    end

    def violations_with_config(config)
      content = <<-TEXT.strip_heredoc
        import java.util.*;
        public class Sample {
          public static void Sample() {
          }

          public void hi(long name) {
            system.out.printf("Hi, " + name);
          }
        }
      TEXT

      violations_in(content, config: config)
    end
  end


  private

  def violations_in(content, config: nil)
    repo_config = double("RepoConfig", enabled_for?: true, for: config)
    style_guide = StyleGuide::Java.new(repo_config)
    style_guide.violations_in_file(build_file(content)).flat_map(&:messages)
  end

  def build_file(content)
    line = double("Line", content: "blah", number: 1, patch_position: 2)
    double("CommitFile", content: content, filename: "lib/a.java", line_at: line)
  end
end
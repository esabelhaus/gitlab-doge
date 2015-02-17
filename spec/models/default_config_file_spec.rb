require "spec_helper"
require "fast_spec_helper"

describe DefaultConfigFile do
  describe "#path" do
    context "thoughtbot repository" do
      it "returns the configuration file used by thoughtbot" do
        config_path = File.join(
          DefaultConfigFile::CONFIG_DIR,
          "javascript.json"
        )
        config = DefaultConfigFile.new("javascript.json")

        expect(config.path).to eq config_path
      end
    end

    context "non-thoughtbot repository" do
      it "returns the default hound configuration" do
        config_path = File.join(
          DefaultConfigFile::CONFIG_DIR,
          "javascript.json"
        )
        config = DefaultConfigFile.new("javascript.json")

        expect(config.path).to eq config_path
      end
    end
  end
end

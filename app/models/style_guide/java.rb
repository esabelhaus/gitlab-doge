module StyleGuide
  class Java < Base
    DEFAULT_CONFIG_FILENAME = "sun_checks.xml"

    def violations_in_file(file)
      team.lint(file.content).compact.map do |violation|
        Violation.new(file, violation[1], violation[0])
      end
    end

    private

    def custom_config
      repo_config.for(name)
    end

    def default_config
      repo_config.for(default_config_file)
    end

    def team
      if custom_config.nil?
        lint = Jlint.new(custom_config)
      else
        lint = Jlint.new(default_config)
      end
      @team ||= lint
    end

    def default_config_file
      DefaultConfigFile.new(DEFAULT_CONFIG_FILENAME).path
    end
  end
end
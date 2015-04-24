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
      File.read(default_config_file)
    end

    def team
      if custom_config.blank?
        @team ||= Jlint.new(default_config)
      else
        @team ||= Jlint.new(custom_config)
      end
    rescue
      Sidekiq.logger.info "An error was found in the custom config"
      Sidekiq.logger.info "Dropping into the default config"
      @team ||= Jlint.new(default_config)
    end

    def default_config_file
      DefaultConfigFile.new(DEFAULT_CONFIG_FILENAME).path
    end
  end
end
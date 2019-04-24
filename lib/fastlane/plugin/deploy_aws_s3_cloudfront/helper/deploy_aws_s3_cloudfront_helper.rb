require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class DeployAwsS3CloudfrontHelper
      # class methods that you define here become available in your action
      # as `Helper::DeployAwsS3CloudfrontHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the deploy_aws_s3_cloudfront plugin helper!")
      end
    end
  end
end

require 'fastlane/action'
require_relative '../helper/deploy_aws_s3_cloudfront_helper'

require 'aws-sdk-s3'
require 'aws-sdk-cloudfront'
require 'mimemagic'

module Fastlane
  module Actions
    class DeployAwsS3CloudfrontAction < Action
      def self.run(params)
        bucket = params[:bucket]
        source = params[:source]
        distribution_id = params[:distribution_id]

        s3client = Aws::S3::Client.new(region: 'us-east-1')

        files = get_files_from_source(source)

        paths = files.map {|file|
          key = file.relative_path_from(Pathname(source)).to_s
          content_type = get_content_type(file)
          s3client.put_object({body: file.open("rb"), bucket: bucket, key: key.to_s, content_type: content_type})
          "/" + key
        }

        cloudfront = Aws::CloudFront::Client.new

        invalidation = {
            distribution_id: distribution_id,
            invalidation_batch: {
                paths: {
                    quantity: paths.size,
                    items: paths,
                },
                caller_reference: SecureRandom.hex
            },
        }

        cloudfront.create_invalidation(invalidation)

      end

      def self.get_files_from_source(source)
        return Dir.glob("#{source}/**/*").select {|f| File.file? f}.map {|f| Pathname(f)}
      end

      def self.get_content_type(file)
        content_type = MimeMagic.by_path(file)
        content_type = 'application/octet-stream' unless content_type
        return content_type.to_s
      end

      def self.description
        "Deploy local directory to AWS S3 bucket and invalidate CloudFront"
      end

      def self.authors
        ["Hector"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
            FastlaneCore::ConfigItem.new(key: :bucket,
                                         env_name: "DEPLOY_AWS_S3_CLOUDFRONT_YOUR_OPTION",
                                         description: "A description of your option",
                                         optional: false,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :source,
                                         env_name: "DEPLOY_AWS_S3_CLOUDFRONT_YOUR_OPTION",
                                         description: "A description of your option",
                                         optional: false,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :distribution_id,
                                         env_name: "DEPLOY_AWS_S3_CLOUDFRONT_YOUR_OPTION",
                                         description: "A description of your option",
                                         optional: false,
                                         type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end

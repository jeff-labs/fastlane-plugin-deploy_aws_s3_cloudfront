describe Fastlane::Actions::DeployAwsS3CloudfrontAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The deploy_aws_s3_cloudfront plugin is working!")

      Fastlane::Actions::DeployAwsS3CloudfrontAction.run(nil)
    end
  end
end

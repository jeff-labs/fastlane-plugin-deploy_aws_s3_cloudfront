describe Fastlane::Actions::DeployAwsS3CloudfrontAction do
  describe '#get_content_type' do
    it 'get file content type' do
      content_type = Fastlane::Actions::DeployAwsS3CloudfrontAction.get_content_type("test.json")
      expect(content_type).to eq("application/json")
    end

    it 'get default content type' do
      content_type = Fastlane::Actions::DeployAwsS3CloudfrontAction.get_content_type("test.asdf")
      expect(content_type).to eq("application/octet-stream")
    end
  end
end

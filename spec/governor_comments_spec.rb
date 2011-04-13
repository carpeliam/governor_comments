require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Governor
  describe GovernorComments do
    it "registers the plugin" do
      Governor::PluginManager.plugins.size == 1
    end
  end
end
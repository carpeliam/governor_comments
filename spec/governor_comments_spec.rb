require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Governor
  describe GovernorComments do
    it "registers the plugin" do
      Governor::PluginManager.plugins.size == 1
    end
  
    it "registers one child resource" do
      PluginManager.resources(:child_resources).size.should == 1
      options = PluginManager.resources(:child_resources)[:comments]
      options.keys.should == [:block]
      options[:block].should be_a Proc
    end
  end
end
require File.dirname(__FILE__) + "/spec_helper"

describe "Debugger.new" do
  it "is private to prevent multiple instances being instantiated" do
    lambda { Debugger.new }.should raise_error(NoMethodError)
  end
end

describe "Debugger.instance" do
  before do
    # Bit of a hack, but this makes each spec start with no Debugger instance
    Debugger.module_eval { @@instance = nil }
    Rubinius::VM.debug_channel = nil
  end

  it "instantiates a new Debugger instance if none exists" do
    Debugger.module_eval { @@instance.should == nil }
    dbg = Debugger.instance
    dbg.class.should == Debugger
    Debugger.module_eval { @@instance.should_not == nil }
  end

  it "retrieves an existing singleton instance" do
    dbg = Debugger.instance
    dbg.should_not == nil
    dbg2 = Debugger.instance
    dbg.should == dbg2
  end
end

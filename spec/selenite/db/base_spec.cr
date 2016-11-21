require "../../spec_helper"

describe Selenite::DB::Base do
  # TODO: Write tests

  describe "the environment" do
    it "should have an APPLICATION_ENV defined" do
      Selenite::DB::Base.env.should eq("development")
    end
  end

  describe "the root" do
    it "should have a root" do
      Selenite::DB::Base.root.should be_a(String)
    end
  end

  describe "the connection" do
    it "should load the basic configuration" do
      Selenite::DB::Base.data["host"].should eq("localhost")
      Selenite::DB::Base.data["user"].should eq("root")
    end

    it "should load a specific configuration" do
      Selenite::DB::Base.data["host"].should eq("localhost")
      Selenite::DB::Base.data["user"].should eq("root")
    end

    it "should have a postgre connection" do
      # puts Selenite::DB::Base.connection
      true.should eq false
    end
  end

end
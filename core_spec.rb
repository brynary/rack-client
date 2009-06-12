require File.dirname(__FILE__) + '/spec_helper'

describe Rack::Client, "without middleware" do
  it "returns an empty body" do
    response = Rack::Client.get("http://localhost:9292/empty")
    response.status.should == 200
    response.headers["Content-Type"].should == "text/html"
    response.headers["Content-Length"].should == "0"
    response.body.should == ""
  end

  it "returns a 302" do
    response = Rack::Client.get("http://localhost:9292/redirect")
    response.status.should == 302
    response["Location"].should == "/after-redirect"
  end

  it "posts data" do
    response = Rack::Client.post("http://localhost:9292/posted", "some data")
    response.status.should == 201
    response["Created"].should == "awesome"
  end
end
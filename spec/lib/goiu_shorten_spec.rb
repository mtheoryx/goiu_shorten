require 'spec_helper'

describe "GoiuShorten expand" do
  it "should return url when given a short url" do
    long_url = GoiuShorten.expand('http://go.iu.edu/4Gb')
    long_url.should_not be_nil
  end

  it "should return the correct url for a given short url" do
    pending
  end

  it "should return an error if the short url is not found" do
    pending
  end
end
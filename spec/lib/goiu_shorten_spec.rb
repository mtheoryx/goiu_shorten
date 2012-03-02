require 'spec_helper'
require 'yaml'

describe "GoiuShorten expand" do

  before(:all) do
    @sample_correct_long_url = "http://www.indiana.edu/~podcast/search/"
    @sample_correct_short_url = "http://go.iu.edu/4Gb"
    @sample_wrong_long_url = "http://davidrpoindexter.com/"
    @sample_wrong_short_url = "http://go.iu.edu/i5"
  end

  it "should return a valid response when given a valid short url" do
    GoiuShorten.expand(@sample_correct_short_url).should_not be_nil
  end

  it "should return the correct url for a given short url" do
    long_url = GoiuShorten.expand(@sample_correct_short_url)
    long_url.should == @sample_correct_long_url
  end

  it "should return an error if you don't supply a short url" do
    GoiuShorten.expand(nil).should raise_exception
  end

  it "should return an error if you supply something other than a valid url" do
    GoiuShorten.expand('simplestringhere').should raise_exception
  end

  it "should return an error if the given short url is not found" do
    GoiuShorten.expand(@sample_wrong_short_url).should raise_exception
  end

  it "should return an error if the given short url is not valid" do
    GoiuShorten.expand('http://go.iu.edu/').should raise_exception
  end
end

describe "GoiuShorten shorten feature" do

  before(:all) do
      @sample_correct_long_url = "http://www.indiana.edu/~podcast/search/"
      @sample_correct_short_url = "http://go.iu.edu/4Gb"
      @sample_wrong_long_url = "http://davidrpoindexter.com/"
      @sample_wrong_short_url = "http://go.iu.edu/i5"
      @sample_wrong_passcode = "11111111-1111-1111-1111-111111111111"
      config = YAML.load_file("config.yaml")
      @sample_correct_passcode = config["config"]["passcode"]
  end

  it "should raise an error if you don't give it any arguments" do
    expect {
      GoiuShorten.shorten()
    }.to raise_error(ArgumentError)
  end

  it "should raise an error if you mix up the order of your arguments" do
    expect {
      GoiuShorten.shorten(@sample_wrong_passcode, @sample_correct_long_url)
    }.to raise_error(ArgumentError)
  end

  it "should raise a descriptive error if you don't supply a correctly formatted passcode" do
    expect {
      GoiuShorten.shorten(@sample_correct_long_url, 'wrongformatpasscode')
    }.to raise_error(ArgumentError, "You must supply a passcode to shorten URLs.")
  end

  it "should raise an error for invalid passcode" do
    expect {
      GoiuShorten.shorten(@sample_correct_long_url, @sample_wrong_passcode)
    }.to raise_error(ArgumentError, "Not a valid passcode.")
  end

  it "should return a short url when given a long url to shorten" do
    GoiuShorten.shorten(@sample_correct_long_url, @sample_correct_passcode).should =~ /^http:\/\/go.iu.edu\//
  end

  it "should return a short url when given a long url" do
      GoiuShorten.shorten(@sample_correct_long_url, @sample_correct_passcode).should == @sample_correct_short_url
    end
end
require 'spec_helper'

describe Entrant do

  before(:each) do 
    @attr = {
      :name => "John Smith",
      :email => "user@example.com",
      :paid => false
    }
  end

  it "should create a new instance given valid attributes" do
    Entrant.create!(@attr)
  end

  it "should require a name" do
    no_name_entrant = Entrant.new(@attr.merge(:name => ""))
    no_name_entrant.should_not be_valid
  end

  it "should reject duplicate names" do
    Entrant.create!(@attr)
    duplicate_name_entrant = Entrant.new(@attr)
    duplicate_name_entrant.should_not be_valid
  end

  it "should require an email address" do
    no_email_entrant = Entrant.new(@attr.merge(:email => ""))
    no_email_entrant.should_not be_valid
  end

  it "should reject a name that is too long" do
    long_email_entrant = Entrant.new(@attr.merge(:name => "a" * 30))
    long_email_entrant.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_entrant = Entrant.new(@attr.merge(:email => address))
      valid_email_entrant.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_entrant = Entrant.new(@attr.merge(:email => address))
      invalid_email_entrant.should_not be_valid
    end
  end

  it "should respond to players" do
    @entrant = Entrant.create!(@attr)
    @entrant.should respond_to(:players)
  end

  it "should respond to picks" do
    @entrant = Entrant.create!(@attr)
    @entrant.should respond_to(:picks)
  end

end

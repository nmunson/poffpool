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

  it "should reject duplicate names"

  it "should require an email address"

  it "should reject a name that is too long"

  it "should accept valid email addresses"

  it "should reject invalid email addresses"

  it "should respond to players"

  it "should respond to picks"

end

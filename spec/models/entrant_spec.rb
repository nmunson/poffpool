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

  context "#points" do
    before(:each) do 
      @entrant = Entrant.create!(@attr)
      player1 = @entrant.players.create!({
        :name => "exampleplayer",
        :team_id => 1
      })
      player2 = @entrant.players.create!({
        :name => "exampleplayer2",
        :team_id => 2
      })
      player1.goals = 1
      player1.assists = 2
      player2.wins = 1
      player2.shutouts = 1
      player2.assists = 1
    end

    it "returns the points count for the entrant" do
      points_sum = 1 + 2 + (Integer(ENV['WIN_MULTIPLIER']) * 1) + 
        (Integer(ENV['SHUTOUT_MULTIPLIER']) * 1) + 1
      @entrant.points.should == points_sum
    end
  end

  context "#yesterdays_rank" do
    before(:each) do
      @entrant = Entrant.create!(@attr)
    end

    it "should return 0 if there are no rankings" do
      @entrant.yesterdays_rank.should == 0
    end

    it "should return 0 if there are no rankings for yesterday" do
      @entrant.rankings.create!(:date => Time.now, :rank => 1)
      @entrant.yesterdays_rank.should == 0
    end

    it "should return the rank from the previous day" do
      @entrant.rankings.create!(:date => Time.now, :rank => 1)
      @entrant.rankings.create!(:date => Time.now - 1.day, :rank => 10)
      @entrant.rankings.create!(:date => Time.now - 2.days, :rank => 20)
      @entrant.yesterdays_rank.should == 10
    end
  end

  context "#todays_rank" do

  end

  context "#rank_change" do 

  end

end

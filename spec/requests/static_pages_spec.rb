require 'spec_helper'

describe "static_pages" do

  subject { page }

  describe "home page" do
    before { visit home_path }

    it { should have_selector('h1', text: "Welcome") }
    it { should have_title("Todo | Home") }
  end

  describe "about" do
    # before { visit about_path }

    # it { should have_selector('h1', text: "About Me") }
    # it { should have_title("Todo | About Me") }
  end

  describe "help" do
    # it should have h1 of "Help / FAQ"
    # it should have a title of "Todo | Help"
  end
end

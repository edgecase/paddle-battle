require 'spec_helper'

describe ApplicationHelper do
  describe "#link_to_with_current" do
    let(:name) { "My Link" }
    let(:url) { "/the/url" }
    subject { helper.link_to_with_current(name, url) }

    context "when the URL is the current page" do
      before { view.stub(:current_page?) { true } }

      it { should include('class="current"') }
    end

    context "when the URL is not the current page" do
      before { view.stub(:current_page?) { false } }

      it { should_not include('class="current"') }
    end
  end

end

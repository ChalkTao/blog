require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ArticlesHelper. For example:
#
# describe ArticlesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe "Get qiniu token" do
    it "returns token" do
      expect(qiniu_token()).to_not be_nil
    end
  end
end

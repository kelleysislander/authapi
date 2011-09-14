require 'test_helper'

class AuthenticationCodeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AuthenticationCode.new.valid?
  end
end

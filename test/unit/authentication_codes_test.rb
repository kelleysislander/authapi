require 'test_helper'

class AuthenticationCodesTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AuthenticationCodes.new.valid?
  end
end

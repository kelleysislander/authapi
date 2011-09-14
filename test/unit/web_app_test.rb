require 'test_helper'

class WebAppTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert WebApp.new.valid?
  end
end

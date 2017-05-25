require 'test_helper'

class KillConfirmationTest < ActiveSupport::TestCase

  def setup
    Rails.application.load_seed
    @kill = Kill.create(killer_id:1, victim_id:2)
    @kc = KillConfirmation.new
    @kc.sender = User.find(1)
    @kc.receiver = User.find(2)
    @kc.kill = @kill
    @kc.save!
  end

  test "confirmation logic" do
    assert_equal @kc.confirmed?, false

    @kc.receiver_accepted = false
    assert_equal @kc.confirmed?, false

    @kc.receiver_accepted = true
    assert @kc.confirmed?

    @kc.verdict = false
    assert_equal @kc.confirmed?, false

    @kc.receiver_accepted = false
    assert_equal @kc.confirmed?, false

    @kc.verdict = true
    assert @kc.confirmed?

    @kc.receiver_accepted = false
    assert @kc.confirmed?
  end

end

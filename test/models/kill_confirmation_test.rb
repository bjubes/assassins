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

  test "a confirmed KC can be approved and vetoed" do
    assert_equal @kc.confirmed?, false

    @kc.accept!
    assert @kc.confirmed?

    @kc.approve!
    assert @kc.confirmed?

    @kc.veto!
    assert_equal @kc.confirmed?, false
  end

  test "a denied KC can be vetoed and approved" do
    @kc.state = :sent
    @kc.deny!
    assert_equal @kc.confirmed?, false

    @kc.approve!
    assert @kc.confirmed?

    @kc.veto!
    assert_equal @kc.confirmed?, false
  end

end

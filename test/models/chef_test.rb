require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "tom", email: "tom@catavenue.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test "email length should be withing bounds" do
    @chef.email = "a" * 101+ "@example.com"
    assert_not @chef.valid?
  end

  test "email address should be unique" do
    copy_chef = @chef.dup
    copy_chef.email = @chef.email.upcase
    @chef.save
    assert_not copy_chef.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com R_TDD@eee.hello.org first.last@ejlj.au laura+jame@kd.com]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_ee.or user.name@example. ee@i_am_.com foo@ee+ar.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be valid'
    end
  end
end

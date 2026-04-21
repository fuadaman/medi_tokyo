require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get emergency" do
    get emergency_url
    assert_response :success
  end

  test "should get insurance guide" do
    get insurance_guide_url
    assert_response :success
  end

  test "insurance guide renders disclosure controllers" do
    get insurance_guide_url
    assert_select "[data-controller='disclosure']"
  end

  test "insurance guide accordion panels start collapsed" do
    get insurance_guide_url
    assert_select "[data-disclosure-target='panel']" do |panels|
      panels.each do |panel|
        assert_match(/max-height:0/, panel["style"].to_s)
      end
    end
  end

  test "insurance guide renders what to bring section" do
    get insurance_guide_url
    assert_select "p", text: /My Number Card|マイナンバーカード/
  end
end

require "test_helper"

class Admin::WallpapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallpaper = wallpapers(:one)
  end

  test "should get index" do
    get wallpapers_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_wallpaper_url
    assert_response :success
  end

  test "should create wallpaper" do
    assert_difference("Admin::Wallpaper.count") do
      post wallpapers_url, params: { wallpaper: { category: @wallpaper.category } }
    end

    assert_redirected_to admin_wallpaper_url(Admin::Wallpaper.last)
  end

  test "should show wallpaper" do
    get admin_wallpaper_url(@wallpaper)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_wallpaper_url(@wallpaper)
    assert_response :success
  end

  test "should update wallpaper" do
    patch admin_wallpaper_url(@wallpaper), params: { wallpaper: { category: @wallpaper.category } }
    assert_redirected_to admin_wallpaper_url(@wallpaper)
  end

  test "should destroy wallpaper" do
    assert_difference("Admin::Wallpaper.count", -1) do
      delete admin_wallpaper_url(@wallpaper)
    end

    assert_redirected_to wallpapers_url
  end
end

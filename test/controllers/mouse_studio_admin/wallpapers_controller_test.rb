require "test_helper"

class MouseStudioAdmin::WallpapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallpaper = wallpapers(:one)
  end

  test "should get index" do
    get wallpapers_url
    assert_response :success
  end

  test "should get new" do
    get new_mouse_studio_admin_wallpaper_url
    assert_response :success
  end

  test "should create wallpaper" do
    assert_difference("MouseStudioAdmin::Wallpaper.count") do
      post wallpapers_url, params: { wallpaper: { category: @wallpaper.category } }
    end

    assert_redirected_to mouse_studio_admin_wallpaper_url(MouseStudioAdmin::Wallpaper.last)
  end

  test "should show wallpaper" do
    get mouse_studio_admin_wallpaper_url(@wallpaper)
    assert_response :success
  end

  test "should get edit" do
    get edit_mouse_studio_admin_wallpaper_url(@wallpaper)
    assert_response :success
  end

  test "should update wallpaper" do
    patch mouse_studio_admin_wallpaper_url(@wallpaper), params: { wallpaper: { category: @wallpaper.category } }
    assert_redirected_to mouse_studio_admin_wallpaper_url(@wallpaper)
  end

  test "should destroy wallpaper" do
    assert_difference("MouseStudioAdmin::Wallpaper.count", -1) do
      delete mouse_studio_admin_wallpaper_url(@wallpaper)
    end

    assert_redirected_to wallpapers_url
  end
end

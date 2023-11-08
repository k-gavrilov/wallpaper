require "application_system_test_case"

class MouseStudioAdmin::WallpapersTest < ApplicationSystemTestCase
  setup do
    @wallpaper = wallpapers(:one)
  end

  test "visiting the index" do
    visit wallpapers_url
    assert_selector "h1", text: "Wallpapers"
  end

  test "should create wallpaper" do
    visit wallpapers_url
    click_on "New wallpaper"

    fill_in "Category", with: @wallpaper.category
    click_on "Create Wallpaper"

    assert_text "Wallpaper was successfully created"
    click_on "Back"
  end

  test "should update Wallpaper" do
    visit mouse_studio_admin_wallpaper_url(@wallpaper)
    click_on "Edit this wallpaper", match: :first

    fill_in "Category", with: @wallpaper.category
    click_on "Update Wallpaper"

    assert_text "Wallpaper was successfully updated"
    click_on "Back"
  end

  test "should destroy Wallpaper" do
    visit mouse_studio_admin_wallpaper_url(@wallpaper)
    click_on "Destroy this wallpaper", match: :first

    assert_text "Wallpaper was successfully destroyed"
  end
end

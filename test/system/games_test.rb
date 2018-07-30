require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "entering an invalid word in /new form gives us an invalid word response" do
    visit new_url
    fill_in "longest_word", with: "abcdef"
    click_on "Play"
    assert_text "Sorry but 'abcdef' can't be built from these letters!"
  end

  test "entering a single letter word in /new form gives us a not-english response" do
    visit new_url
    fill_in "longest_word", with: "f"
    click_on "Play"
    assert_text "Sorry but 'f' isn't English!"
  end
end

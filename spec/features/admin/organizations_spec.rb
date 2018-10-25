RSpec.feature "Organizations Admin" do
  before :each do
    sign_in(@super_admin)
  end

  scenario "creating a new organization" do
    visit new_admin_organization_path
    screenshot_and_open_image
    click_link "Add New Organization"
    org_params = attributes_for(:organization)
    fill_in "Name", with: org_params[:name]
    fill_in "Short name", with: org_params[:short_name]
    fill_in "Url", with: org_params[:url]
    fill_in "Email", with: org_params[:email]
    fill_in "Street", with: "1500 Remount Road"
    fill_in "City", with: "Front Royal"
    select("VA", from: "State")
    fill_in "Zipcode", with: "22630"

    click_on "Save"

    expect(page).to have_content("All Diaperbase Organizations")

    within("tr.#{org_params[:short_name]}") do
      first(:link, "View").click
    end

    expect(page).to have_content(org_params[:name])
    expect(page).to have_content("Remount")
    expect(page).to have_content("Front Royal")
    expect(page).to have_content("VA")
    expect(page).to have_content("22630")
  end
end
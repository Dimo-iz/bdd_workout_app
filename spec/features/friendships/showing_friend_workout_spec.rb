require 'rails_helper'

RSpec.feature 'Showing friend workout' do
  before do
    @john = User.create!(first_name: 'John', last_name: 'Doe', email: "john@example.com",
                         password: "password")

    @sarah = User.create!(first_name: 'Sarah', last_name: 'Anderson', email: "sarah@example.com",
                          password: "password")

    login_as @john

    @e1 = @john.exercises.create(duration_in_min: 20, workout: 'My body building activity', workout_date: Date.today)
    @e2 = @jsarah.exercises.create(duration_in_min: 55, workout: 'Weight lifting', workout_date: Date.today)

    @following = Friendship.create(friend: @sarah, user: @john)

  end

  scenario 'shows friend workout for last 7 days' do
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content(@sarah.full_name + "'s Exercises'")
    expect(page).to have_content @e2.workout
    expect(page).to have_css 'div#chart'


  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Video.create("/home/ubuntu/environment/fighting-aggies-platform/storage/supplementary_video.mp4")

initial_users = [
  { name: 'Tuong Tran', role: 'Admin', email: 't2tran@tamu.edu' },
  { name: 'Test User', role: 'Coach', email: 'faaplicationuser@gmail.com' },
  { name: 'Test Admin', role: 'Admin', email: 'faaplicationmanager@gmail.com' },
  { name: 'Andrew Imwalle', role: 'Admin', email: 'andrew.imwalle@tamu.edu' },
  { name: 'Nick McDonough', role: 'Admin', email: 'nimcd@tamu.edu' },
  { name: 'Eli Tracy', role: 'Admin', email: 'elitracy@tamu.edu' },
  { name: 'Bob Jones', role: 'Coach', email: 'bob.jones@tamu.edu' },
  { name: 'Dylan Nguyen', role: 'Admin', email: 'dylann123@tamu.edu' },
  { name: 'Obama Redacted', role: 'Coach', email: 'potus52@gmail.com' },
  { name: 'Joe Mama', role: 'Coach', email: 'joewho@yahoo.com' },
  { name: 'Professor Oak', role: 'Coach', email: 'prof.oak@hotmail.com' },
  { name: 'Bobobo-bo Bo-bobo', role: 'Coach', email: 'howwasthisanactualcharacter@gmail.com' },
  { name: 'Not Available', role: 'Coach', email: 'nslasha@gmail.com' },
  { name: 'Boaty McBoatFace', role: 'Coach', email: 'boat@gmail.com' }
]

initial_users.each do |user|
  User.create!(user)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
[Question, Answer, AdminUser, User].each(&:destroy_all)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', first_name: 'Admin', last_name: 'affif') if Rails.env.development?
User.create!(email: 'affif.amine@live.fr', password: 'password', password_confirmation: 'password', first_name: 'Amine', last_name: 'affif') if Rails.env.development?

30.times do |i|
  question = Question.create!(
    text: "Question #{i + 1}?",
    right_answer_id: nil
  )

  answer1 = question.answers.create!(
    text: "Réponse 1 pour Question #{i + 1}"
  )
  
  answer2 = question.answers.create!(
    text: "Réponse 2 pour Question #{i + 1}"
  )

  # Définir l'une des réponses comme bonne réponse
  question.update!(right_answer_id: [answer1.id, answer2.id].sample)
end

puts "Created #{Question.count} questions with 2 answers each."
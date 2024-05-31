require 'csv'

# Supprimer les données existantes
[Question, Answer, AdminUser, User].each(&:destroy_all)

# Créer des utilisateurs de test
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', first_name: 'Admin', last_name: 'affif') if Rails.env.development?
User.create!(email: 'affif.amine@live.fr', password: 'password', password_confirmation: 'password', username: 'amine75', first_name: 'Amine', last_name: 'affif') if Rails.env.development?

# Lire le fichier CSV et forcer l'encodage UTF-8
csv_text = File.read(Rails.root.join('lib', 'seeds', 'merged_seed.csv'), encoding: 'UTF-8')

# Analyser le fichier CSV
csv = CSV.parse(csv_text, headers: true)

# Insérer les données dans la base de données
csv.each do |row|
  question_text = row['question_text'].to_s.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?').strip
  answer_text = row['answer_text'].to_s.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?').strip
  is_correct = row['is_correct'] == 'True'

  question = Question.find_or_create_by(text: question_text)
  answer = question.answers.create(text: answer_text)

  if is_correct
    question.update(right_answer_id: answer.id)
  end
end

puts "Il y a maintenant #{Question.count} questions dans la base de données."
puts "Il y a maintenant #{Answer.count} réponses dans la base de données."


# 30.times do |i|
#   question = Question.create!(
#     text: "Question #{i + 1}?",
#     right_answer_id: nil
#   )

#   answer1 = question.answers.create!(
#     text: "Réponse 1 pour Question #{i + 1}"
#   )
  
#   answer2 = question.answers.create!(
#     text: "Réponse 2 pour Question #{i + 1}"
#   )

#   # Définir l'une des réponses comme bonne réponse
#   question.update!(right_answer_id: [answer1.id, answer2.id].sample)
# end

# puts "Created #{Question.count} questions with 2 answers each."
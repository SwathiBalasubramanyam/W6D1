# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ApplicationRecord.transaction do
    # Destroy tables (not necessary if using `rails db:seed:replant`)
    puts 'Destroying tables...'
    User.destroy_all
    Poll.destroy_all
    Question.destroy_all
    AnswerChoice.destroy_all
    Response.destroy_all
    
    # Reset primary keys (i.e., ids) 
    puts 'Resetting id sequences...'
    %w(users polls questions answer_choices responses).each do |table_name|
      ApplicationRecord.connection.reset_pk_sequence!(table_name)
    end
  
    # Create seed data
    puts 'Creating seed data...'
    u1 = User.create!(user_name: 'AR')
    u2 = User.create!(user_name: 'SB')
    u3 = User.create!(user_name: 'DA')
    u4 = User.create!(user_name: 'AA')
    
    p1 = Poll.create!(author_id: u1.id, title: "Travel")
    p2 = Poll.create!(author_id: u2.id, title: "Food")


    q1 = Question.create!(poll_id: p1.id, text: "Beach today??")
    q2 = Question.create!(poll_id: p1.id, text: "What do we need to buy for our  san-deigo trip??")
    
    a1 = AnswerChoice.create!(question_id: q1.id, text: "Yes!!!")
    a2 = AnswerChoice.create!(question_id: q1.id, text: "No :(")

    a3 = AnswerChoice.create!(question_id: q2.id, text: "hats, beach towels")
    a4 = AnswerChoice.create!(question_id: q2.id, text: "sunglasses, sunscreen")
    a5 = AnswerChoice.create!(question_id: q2.id, text: "Clothes")

    r1 = Response.create!(question_id: q1.id, answer_choice_id: a1.id, user_id: u3.id)
    r2 = Response.create!(question_id: q1.id, answer_choice_id: a2.id, user_id: u4.id)

    r3 = Response.create!(question_id: q2.id, answer_choice_id: a3.id, user_id: u3.id)
    r4 = Response.create!(question_id: q2.id, answer_choice_id: a4.id, user_id: u4.id)
    

    q3 = Question.create!(poll_id: p2.id, text: "what do you guys wanna eat for dinner??")
    q4 = Question.create!(poll_id: p2.id, text: "Do you guys wanna go out for lunch??")
    q5 = Question.create!(poll_id: p2.id, text: "where do you wanna eat lunch??")


    
    puts 'Done!'
  end
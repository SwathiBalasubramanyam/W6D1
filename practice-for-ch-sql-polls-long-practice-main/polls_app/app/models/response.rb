class Response < ApplicationRecord

    validate :respondent_already_answered?, :author_is_respondent?

    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: :AnswerChoice

    has_one :question,
        through: :answer_choice,
        source: :question

    has_one :poll,
        through: :question,
        source: :poll

    def sibling_responses
        self.question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?
        if self.sibling_responses.exists?(user_id: self.user_id)
            errors.add(:user_id, "You have already answered this question")
        end
    end

    def author_is_respondent?
        if self.poll.author_id == self.user_id
            errors.add(:user_id, "Authors cannot respond to their own polls")
        end
    end


end
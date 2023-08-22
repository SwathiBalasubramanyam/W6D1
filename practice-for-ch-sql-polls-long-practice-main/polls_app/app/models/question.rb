class Question < ApplicationRecord

    belongs_to :poll,
        primary_key: :id,
        foreign_key: :poll_id,
        class_name: :Poll

    has_many :answer_choices,
        primary_key: :id,
        foreign_key: :question_id,
        class_name: :AnswerChoice,
        dependent: :destroy

    has_many :responses,
        through: :answer_choices,
        source: :responses

    def results_n
        acs = self.answer_choices
        res_hash = {}
        acs.each {|ac|
            res_hash[ac.text] = ac.responses.count
        }
        res_hash
    end

    def results
        acs = self.answer_choices.includes(:responses)
        res_hash = {}
        acs.each {|ac|
            res_hash[ac.text] = ac.responses.length
        }
        res_hash
    end

    def results_better
        acs = self.answer_choices
            .joins(:responses)
            .select('answer_choices.id, answer_choices.text, count(responses.id)')
            .group('answer_choices.id, answer_choices.text')

        res_hash = {}
        acs.each {|ac|
            res_hash[ac.text] = ac.count
        }
        res_hash

    end

end
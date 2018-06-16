class Game < ActiveRecord::Base
    validates :winner, :loser, :lrank, :wrank, presence: true
end

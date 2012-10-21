class Movie < ActiveRecord::Base

  def self.all_ratings
    # returns all possible rating values, i.e.['G','PG','PG-13','R']
    return ['G','PG','PG-13','R']
  end

end




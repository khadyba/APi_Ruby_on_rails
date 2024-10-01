class Author < ApplicationRecord

    validates :name, presence: true ,uniqueness: true
    validates :age, presence: true 
   
    has_many :books, dependent: :destroy

end

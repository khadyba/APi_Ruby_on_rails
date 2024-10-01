module Api
# les methode de la version 1 de l'api
  module V1

    class AuthorsController < ApplicationController
      # methode pour recupérer tout les auteurq
      def index
        @authors = Author.all
        render json: { authors: @authors }
      end
      # methode pour récuperer un seul auteurs
      def show
        author = Author.find_by(id:params[:id])
        if author
          render json:{author:author}
          
        else
          render json: {message:"author doesn't exist"}, status: 400
          
        end
        
      end
      
    end

  end

end

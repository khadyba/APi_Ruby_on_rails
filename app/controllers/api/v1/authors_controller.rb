module Api
# les methode de la version 1 de l'api
  module V1

    class AuthorsController < ApplicationController

      before_action :authorize_request, only: [:create, :destroy]
        
     # Méthode pour créer un auteur
      def create
        @author = Author.new(author_params)
        
        if @author.save
          render json: { author: @author }, status: :created
        else
          render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
        end
      end
      # methode pour recupérer tout les auteurs
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
      # methode pour supprimer  
      def destroy
        destroy = Author.find(params[:id]).destroy
        render  status: :no_content
        # json: {destroy: Author.find(params[:id]).destroy}

      end
      #  methode priver pour les parametre d'un author
      private 
      def author_params
        params.require(:author).permit(:name, :age)
      end
      
    end

  end

end

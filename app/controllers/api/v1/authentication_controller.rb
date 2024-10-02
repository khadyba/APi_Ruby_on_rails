require 'jwt'

module Api
  module V1
    class AuthenticationController < ApplicationController

      private

      def authentication_params
        params.require(:authentication).permit(:email, :password)
      end

      public

      def login
        @user = User.where(email: authentication_params[:email]).first # Utilise .first pour obtenir un seul utilisateur
        
        if @user # Vérifie si un utilisateur a été trouvé
          # Vérifie si le mot de passe correspond à celui stocké dans password_digest
          if @user.authenticate(authentication_params[:password])
            # Crée un token
            exp = 172800 # 2 jours
            token = JWT.encode({
              sub: @user.id, # Utilise @user ici
              exp: Time.now.to_i + exp 
            }, ENV["JWT_SECRET"], 'HS256')
            render json: { user: @user, token: token }
          else
            render json: { errors: "Credentials incorrect" }
          end
        else
          render json: { errors: "Credentials incorrect" }
        end
      end    
    end
  end
end

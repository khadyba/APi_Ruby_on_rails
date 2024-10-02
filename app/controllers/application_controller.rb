class ApplicationController < ActionController::API
    
    def ping
        render json: { response: "pong" }
    end

        # vérifier que le token est valide 
        def authorize_request
            header = request.headers["Authorization"]
            token = header.split(' ')[1] if header
            begin
              decoded = JWT.decode(token, ENV["JWT_SECRET"])
              p decoded
              @current_user = User.find(decoded[0]["sub"])
            rescue ActiveRecord::RecordNotFound => e
              render json: { errors: e.message }, status: :unauthorized
            rescue JWT::DecodeError => e  # Correction ici
              render json: { errors: e.message }, status: :unauthorized
            end
          end
          
end

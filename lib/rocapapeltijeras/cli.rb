module RocaPapelTijeras

  module Cli

    EXIT_COMMANDS = ['q', 'quit', 'sal', 'deja', 'exit']

    def verify_response(response, acceptable_responses)
      if acceptable_responses.include?(response)
        return response
      elsif EXIT_COMMANDS.include?(response)
        exit_game
      else
        while !acceptable_responses.include?(response)
          puts "Lo siento, '#{response}' no es no es una respuesta válida. Lo intenta de nuevo."
          response = gets.chomp.downcase
        end
      end
      response
    end

    def exit_game
      puts "Ok ciao."
      exit
    end

  end

end

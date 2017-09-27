require "rocapapeltijeras/version"
require "rocapapeltijeras/asci_art"
require 'rocapapeltijeras/cli'
require 'rocapapeltijeras/game'

module RocaPapelTijeras

  class RPT
    include Cli

    attr_accessor :play_game

    def initialize
      @play_game = true
    end

    def welcome_player
      puts AsciiArt::TITLE
      puts "Bienvenido a Roca Papel Tijeras!"
      puts "El ganador es el jugador que gané la mayoría de las 3 vueltas."
      puts "Oprima 'sal' para salir de este programa."
    end

    def request_player_count
      puts "Quantos jugadors? 1 o 2?"
      response = gets.chomp
      verify_response(response, ['1', '2'])
    end

    def determine_type_of_game(player_count)
      if player_count == "1"
        return 'one_player'
      else player_count == "2"
        return 'two_player'
      end
    end

    def play_again?
      puts "Quisiera jugar otra vez? S | N"
      player_response = gets.chomp.upcase
      if player_response == "S"
        return true
      elsif player_response == "N"
        exit_game
      else
        puts "Lo siento, no es una respuesta válida. Lo intenta de nuevo."
        play_again?
      end
    end
  end

  rpt = RPT.new
  while rpt.play_game
    rpt.welcome_player
    game_type = rpt.determine_type_of_game(rpt.request_player_count)
    if game_type == 'one_player'
      game = Game.new
      game.play_one_player
    else
      game = Game.new
      game.play_two_player
    end

    rpt.play_game = rpt.play_again?
  end
end

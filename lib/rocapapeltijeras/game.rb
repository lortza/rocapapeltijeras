require_relative 'cli'

module RocaPapelTijeras

  class Game
    include Cli

    attr_accessor :player1_score, :player2_score, :round_winner, :game_winner, :round_number

    def initialize
      @player1_score = 0
      @player2_score = 0
      @round_winner = ''
      @game_winner = ''
      @round_number = 1
    end

    def play_one_player
      play("La Computadora", Proc.new {computer_makes_choice})
    end

    def play_two_player
      play("Jugador 2", Proc.new { request_player_choice })
    end

    private

    WEAPONS = ['r', 'p', 't']

    def computer_makes_choice
      WEAPONS.sample
    end

    def announce_round
      puts '','-' * 15
      puts "Vuelta #{@round_number}!"
      puts '-' * 15
      @round_number += 1
    end

    def request_player_choice
      puts "Por favor, escoja un arma: 'r', 'p', o 't'"
      puts "r: Roca"
      puts "p: Papel"
      puts "t: Tijeras"
      response = gets.chomp.downcase
      verify_response(response, WEAPONS)
    end

    def determine_round_winner(player1_weapon, player2_weapon)
      if player1_weapon == player2_weapon
        @round_winner = 'tie'
      elsif player1_weapon == "r" && player2_weapon == "p"
        @round_winner = 'player2'
      elsif player1_weapon == "p" && player2_weapon == "t"
        @round_winner = 'player2'
      elsif player1_weapon == "t" && player2_weapon == "r"
          @round_winner = 'player2'
      else
        @round_winner = 'player1'
      end
    end

    def announce_round_winner(player2_name)
      if @round_winner == 'tie'
        puts "No hay un ganador de esta vuelta."
      elsif @round_winner == 'player1'
        puts "Jugador 1 ganó la vuelta."
      else
        puts "#{player2_name} ganó la vuelta."
      end
      puts "El resultado actual: Jugador 1: #{@player1_score} | #{player2_name}: #{@player2_score}"
    end

    def determine_game_winner
      if @player1_score == @player2_score
        @game_winner = 'tie'
      elsif @player1_score > @player2_score
        @game_winner = 'player1'
      else
        @game_winner = 'player2'
      end
    end

    def award_points
      if @round_winner == 'tie'
      elsif @round_winner == 'player1'
        @player1_score += 1
      else
        @player2_score += 1
      end
    end

    def announce_game_winner(player2_name)
      if @game_winner == 'tie'
        puts "No hay un ganador del juego."
      elsif @game_winner == 'player1'
        puts "Jugador 1 ganó el juego!"
      else
        puts "#{player2_name} ganó el juego!"
      end
    end

    def clear_screen
      Gem.win_platform? ? (system "cls") : (system "clear")
    end

    def play(player2_name, weapon_selection_proc)
      clear_screen
      puts "Esta jugando contra #{player2_name}."
      3.times do
        announce_round
        puts "El Turno de Jugador 1:"
        player1_choice = request_player_choice
        puts "","El Turno de #{player2_name}:"
        player2_choice = weapon_selection_proc.call
        puts "#{player2_name} ha escogido: #{player2_choice}"
        determine_round_winner(player1_choice, player2_choice)
        award_points
        announce_round_winner(player2_name)
      end
      determine_game_winner
      announce_game_winner(player2_name)
    end

  end
end

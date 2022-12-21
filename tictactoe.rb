class TicTacToe
  attr_reader :tabuleiro, :winner, :game_status
  num_keys = Array(1..9)
  posicoes_possiveis = Array(0..2).repeated_permutation(2).to_a

  # Numeros sao as keys, e o array [linha, coluna] os valores
  @@num_pos_hash = [num_keys, posicoes_possiveis].transpose.to_h
  def initialize
    @pos_disponiveis = Array(1..9)
    @tabuleiro = @pos_disponiveis.each_slice(3).to_a
    @game_status = true
  end


  def draw
    puts ''
    @tabuleiro.each do |line|
      line.each {|element| print " |#{element}| "}
      puts ''
    end
    puts ''
  end

  def fazer_jogada(player)
    # getting player move
    # { player.team => num }
    hash_jogada = receber_jogada(player)
    ident = hash_jogada.keys[0]
    jogada = hash_jogada[player.team]

    if validar_jogada(jogada)
      linha = @@num_pos_hash[jogada][0]
      coluna = @@num_pos_hash[jogada][1]
      @tabuleiro[linha][coluna] = ident
      # Drawning and checking for winner
      draw
      check_winner
    else
      # Recursive function to validate data
      puts "Entre com uma posicao valida"
      fazer_jogada(player)
    end
  end

  def receber_jogada(player)

    print "Jogador #{player.team} Escolha um numero que ainda nao foi escolhido (0-9): "
    num = gets.chomp.to_i

    until @pos_disponiveis.include? num
      print "Jogador #{player.team} Escolha um numero que ainda nao foi escolhido (0-9): "
      num = gets.chomp.to_i
    end

    { player.team => num }
  end

  def validar_jogada(jogada)
    unless @pos_disponiveis.include? jogada
      false
    else
      @pos_disponiveis.delete(jogada)
      true
    end
  end

  def check_winner
    # Check if each line have 3 identical values, if true, finish the game and change
    # the instance atribute @winner. The instance of the TicTacToe class is a especific
    # TicTacToe round.

    # Lines
    check_lines

    # Columns
    check_columns


    # Diagonals
    leading_diagonal
    secondary_diagonal
  end

  def check_lines
    @tabuleiro.each do |line|
      first_condition = line[0] == line[1]
      second_condition = line[1] == line[2]
      has_value = !(@pos_disponiveis.include? line[1])
      next unless first_condition && second_condition && has_value

      @game_status = false
      @winner = line[0]
      break
    end
  end

  def check_columns
    @tabuleiro.transpose.each do |column|
      first_condition = column[0] == column[1]
      second_condition = column[1] == column[2]
      has_value = has_value = !(@pos_disponiveis.include? column[0])

      next unless first_condition && second_condition && has_value

      @game_status = false
      @winner = column[0]
      break
    end
  end

  def leading_diagonal
    first_condition = @tabuleiro[0][0] == @tabuleiro[1][1]
    second_condition = @tabuleiro[0][0] == @tabuleiro[2][2]
    has_value = !(@pos_disponiveis.include? @tabuleiro[0][0])
    return unless first_condition && second_condition && has_value

    @game_status = false
    @winner = @tabuleiro[0][0]
  end

  def secondary_diagonal
    first_condition = @tabuleiro[0][2] == @tabuleiro[1][1]
    second_condition = @tabuleiro[0][2] == @tabuleiro[2][0]
    has_value = !(@pos_disponiveis.include? @tabuleiro[0][2])
    return unless  first_condition && second_condition && has_value

    @game_status = false
    @winner = @tabuleiro[0][2]
  end

  def game_match(player1, player2)
    while game_status == true
      fazer_jogada(player1)
      break unless game_status

      fazer_jogada(player2)
      break unless game_status
    end
  end

  def congrat_winner
    print "Congrants #{@winner}. You won"
  end
end


class Player
  attr_accessor :winner
  attr_reader :team, :name

  def initialize(team = 'x', human = true, winner = nil)
    @team = team
    @human = human
    @winner = winner
  end
end

jogo = TicTacToe.new
player = Player.new
pc = Player.new(team = 'O', human = false)

jogo.draw
jogo.game_match(player, pc)
jogo.congrat_winner





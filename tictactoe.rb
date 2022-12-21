class TicTacToe
  attr_reader :tabuleiro, :winner, :game_status

  def initialize
    @tabuleiro = Array.new(3) { Array.new(3, ' ') }
    @game_status = true
  end

  def draw
    puts ''
    @tabuleiro.each { |line| p line }
    puts ''
  end

  def fazer_jogada(player)
    # getting player move
    hash_jogada = receber_jogada(player)
    ident = hash_jogada.keys[0]
    jogada = hash_jogada[player.team]

    if validar_jogada(jogada[:linha] - 1, jogada[:coluna] - 1)
      @tabuleiro[jogada[:linha] - 1][jogada[:coluna] - 1] = ident
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
    print 'Entre com a linha: '
    linha = gets.chomp.to_i
    if linha > 3
      linha = 3
    elsif linha < 1
      linha = 1
    end

    print 'Entre com a coluna: '
    coluna = gets.chomp.to_i
    if coluna > 3
      coluna = 3
    elsif coluna < 1
      coluna = 1
    end

    { player.team => { linha: linha, coluna: coluna } }
  end

  def validar_jogada(linha, coluna)
    return false unless @tabuleiro[linha][coluna] == ' '

    true
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
      has_value = line[1] != ' '
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
      has_value = column[1] != ' '

      next unless first_condition && second_condition && has_value

      @game_status = false
      @winner = column[0]
      break
    end
  end

  def leading_diagonal
    first_condition = @tabuleiro[0][0] == @tabuleiro[1][1]
    second_condition = @tabuleiro[0][0] == @tabuleiro[2][2]
    has_value = @tabuleiro[0][0] != ' '
    return unless first_condition && second_condition && has_value

    @game_status = false
    @winner = @tabuleiro[0][0]
  end

  def secondary_diagonal
    first_condition = @tabuleiro[0][2] == @tabuleiro[1][1]
    second_condition = @tabuleiro[0][2] == @tabuleiro[2][0]
    has_value = @tabuleiro[0][2] != ' '
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
player = Player.new()
pc = Player.new(team = '0', human = false)

jogo.draw
jogo.game_match(player, pc)
jogo.congrat_winner





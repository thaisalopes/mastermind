class Game
  def initialize
    @round = 1
    @guess = ""
    @board = Board.new
    @guess_maker = Guess_Maker.new
    @code_maker = Code_Maker.new
    @victory = false
    full_game
  end

  def full_game
    while @round <=12 && @victory == false
      @guess = @guess_maker.make_guess
      @code = @code_maker.make_code
      compare_guess(@guess, @code)
      if @victory == false
        show_result
        check_all_correct(@guess, @code)
        check_included(@guess,@code)
      end
      @round += 1
    end
  end

  def compare_guess(guess,code)
    if guess == code
      puts "Congratulations, you won! It took you #{@round} guesses."
      return @victory = true
    else 
      puts "Try again"
    end
  end

  def show_result
    @board.add_guess(@guess)
    @board.show_game_board
  end

  def check_all_correct (guess, code)
    number = 0
    if code.split('')[0] == guess.split('')[0]
      number +=1
    end
    if code.split('')[1] == guess.split('')[1]
      number +=1
    end
    if code.split('')[2] == guess.split('')[2]
      number +=1
    end
    if code.split('')[3] == guess.split('')[3]
      number +=1
    end
    puts "There are #{number} numbers in the correct place"
  end

  def check_included (guess, code)
    number = 0
    code_array = code.split('')
    guess_array = guess.split('')
    guess_array.each { |digit| 
      if code_array.include?(digit) == true
        number =+1
      end
    }
    puts number
  end

end

class Board 
  EMPTY_LINE = "\n_ _ _ _"
  def initialize
    @game_board = ""
    @code = ""
  end

  def show_game_board
    puts @game_board + EMPTY_LINE
  end

  def add_guess(guess)
    formatted_guess = ""
    guess.each_char { |char| formatted_guess += char + ' ' }
    @game_board += "\n#{formatted_guess}"
  end
end

class Guess_Maker
  def initialize
    @guess = ""
  end

  def make_guess
    puts "\nPlease make your guess of a 4 digit number"
    @guess = gets.chomp
    if @guess.length != 4 
      puts "Your guess should have 4 digits"
      make_guess
    end
    puts "Guess = #{@guess}"
    return @guess
  end
end

class Code_Maker
  def initialize
    @player_type = "CPU"
    @code = ""
  end

  def make_code
    while @code.length <4
    @code += rand(10).to_s
    end
    puts @code
    return @code
  end
end

current_game = Game.new
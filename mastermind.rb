class Game
  def initialize(code_maker,guess_maker)
    @round = 1
    @guess = ""
    @board = Board.new
    @guess_maker = guess_maker
    @code_maker = code_maker
    @code = @code_maker.make_code
    @victory = false
    play_round
  end

  def play_round    
    while @round <=12 && @victory == false
      if @victory == false
        @guess = @guess_maker.make_guess
        compare_guess
      end
      @round += 1
    end
  end

  def compare_guess
    if @guess == @code
      if @round == 1
        puts @board.add_guess(@guess)
        puts "\nCongratulations, you won after only one guess!"
        return @victory = true
      else
        puts @board.add_guess(@guess)
        puts "\nCongratulations, you won! It took you #{@round} guesses."
        return @victory = true
      end
    else 
      show_result
      puts "\nTry again"
    end
  end

  def show_result
    @board.add_guess(@guess)
    @board.show_game_board
    all_correct = check_all_correct
    included = check_included - check_all_correct
    if all_correct == 1 && included == 1
      puts "\nThere is 1 number in the right position. 1 number is correct, but in the wrong position."
    elsif 
      all_correct == 1 && included != 1
      puts "\nThere is 1 number in the right position. #{included} numbers are correct, but in the wrong position."
    elsif
      all_correct != 1 && included == 1
      puts "\nThere are #{all_correct} numbers in the right position. 1 number is correct, but in the wrong position."
    else
      puts "\nThere are #{all_correct} numbers in the right position. #{included} numbers are correct, but in the wrong position."
    end
  end

  def check_all_correct
    number = 0
    if @code[0] == @guess[0]
      number +=1
    end
    if @code[1] == @guess[1]
      number +=1
    end
    if @code[2] == @guess[2]
      number +=1
    end
    if @code[3] == @guess[3]
      number +=1
    end
    return number
  end

  def check_included
    number = 0
    code_array = @code.split('')
    guess_array = @guess.split('')
    guess_array.each { |digit| 
      if code_array.include?(digit) == true
        number += 1
      end
    }
    return number
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

class Human
  def make_guess
    puts "\nPlease make your guess of a 4 digit number"
    @guess = gets.chomp
    if @guess.length != 4 
      puts "Your guess should have 4 digits"
      make_guess
    end
    return @guess
  end

  def make_code
    puts "\nPlease input your 4 digit code"
    @code = gets.chomp
    if @code.length != 4
      puts "Your code should have 4 digits"
      make_code
    end
    return @code
  end
end

class CPU
  def initialize
    @code = ""
    @guess = ""
  end

  def make_guess
    @guess = ""
    while @guess.length <4
      @guess += rand(10).to_s
    end
      return @guess
  end

  def make_code
    while @code.length <4
      @code += rand(10).to_s
    end
    return @code
  end
end

class Game_Builder

  def create_set_up
    puts "\nPlease choose who will create the code and who will guess - H for human and C for computer" 
    puts "\nExamples: HC if you want a human to create the code and a computer to guess"
    puts "\nCH if you want a computer to create the code and you (human) will guess."
    set_up = gets.chomp.downcase

    case set_up
    when "ch"
      code_maker = CPU.new
      guess_maker = Human.new
    when "cc"
      code_maker = CPU.new
      guess_maker = CPU.new
    when "hh"
      code_maker = Human.new
      guess_maker = Human.new
    when "hc"
      code_maker = Human.new
      guess_maker = CPU.new
    else
      puts "\nThis is not a valid choice"
      create_set_up
    end
    current_game = Game.new(code_maker,guess_maker)
  end
end

Game_Builder.new.create_set_up

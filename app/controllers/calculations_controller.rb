class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    #@text_wo_spaces = @text.gsub(" ","")
    #@character_count_without_spaces = @text_wo_spaces.length
    @character_count_without_spaces = @text.length - (@text.count " ")

    @word_count = @text.split.size

    @occurrences = @text.split.count @special_word

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    rate = (@apr/12)/100 #monthly interest rate
    months = @years*12 #number of monthly payments

    @monthly_payment = (rate*@principal)/(1-(1+rate)**(months*-1))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min #@sorted_numbers[0]

    @maximum = @numbers.max #@sorted_numbers[-1]

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@count-1)/2] + @sorted_numbers[@count/2])/2

    @sum = @numbers.reduce(:+)

    @mean = @sum/@count

    sq_diff = @numbers.map { |x| ((x-@mean)**2) }
    sum_sq = sq_diff.reduce(:+)
    @variance = sum_sq/@count

    @standard_deviation = @variance**(1.to_f/2.to_f)

    @mode = @numbers.max_by { |x| @numbers.count(x)}
    #freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    #@mode = @numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

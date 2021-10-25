#colors= ["R","Y","G","B","P","O"]]
module Checker
    def col_check(str)
        if str.split("").uniq.length<4
            p "cannot repeat a color"
            return false
        elsif str.length>4 || str.length<4
            p "not 4 colors picked"
            return false
        elsif /[R,Y,G,B,P,O]{4}/.match(str)
            return true
        else
            p "invalid color found"
            return false
        end
    end
end

class Maker
    attr_reader:code
    def initialize(code=askCode())
        @code=code
    end
    def feedback(guess)
        color_with_i=0
        color=0
        guess.each_with_index do |g_color,g_i|
            @code.each_with_index do |c_color, c_i|
                if g_color==c_color
                    if g_i==c_i
                        color_with_i+=1
                    else
                        color+=1
                    end
                end
            end
        end
        feedback=[color,color_with_i,@code==guess]
        return feedback
    end
end

class Breaker
    include Checker
    attr_reader:tries
    def initialize(isAi=false)
        @isAi=isAi
        @tries=12
    end

    def guess(fb)
        if @isAi
            return aiGuess(fb)
        end
        check=false
        puts "Please enter 4 letters:"
        while !check
            puts "#{@tries} tries left"
            guess= gets.chomp
            guess=guess.upcase()
            check=col_check(guess)
        end
        @tries-=1
        return guess.split("")
    end

    def aiGuess(fb)
        @tries-=1
        if fb[0].to_i+fb[1].to_i==4
            @lastguess.shuffle!
            puts "I chose #{@lastguess}, found colors!"
            return @lastguess
        else
            ran=randomGuess()
            puts "I chose #{ran}"
            @lastguess=ran
            return ran
        end
    end
end

def randomGuess()
    str=["R","Y","G","B","P","O"]
    str.shuffle!
    return str[0,4]
end

def askCode()
    extend Checker
    check=false
    puts "Please enter a code:"
    while !check
        guess= gets.chomp
        guess=guess.upcase()
        check=col_check(guess)
    end
    return guess.split("")    
end

def feedback_interpreter(feedback)
    if feedback[2]==true
        puts "You win"
    else
        puts "#{feedback[0]} of colors match, but do not match pos, #{feedback[1]} of colors match fully"
    end
end

def choose()
    puts "please choose maker(1) or breaker(2)"
    str=gets.chomp
    if str=="1"
        return "1"
    elsif str=="2"
        return "2"
    else
        return "bad choice"
    end
end


def start()
    choice=choose()
    if choice=="1"
        ai=Maker.new()
        p1=Breaker.new(true)
    else
        ai=Maker.new(randomGuess()) 
        p1=Breaker.new()  
    end  
    p ai.code()
    puts "R Y G B P O"
    feedback=[0,0,false]
    while feedback[2]!=true && p1.tries()>0
        myguess=p1.guess(feedback)  
        feedback = ai.feedback(myguess) 
        feedback_interpreter(feedback)
    end
end

start()

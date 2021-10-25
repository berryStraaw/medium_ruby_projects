
class Board

    def initialize()
        @board=[]
        3.times do |time|
            @board[time]=[]
            3.times do |col|
                @board[time][col]=""
            end
        end
    end

    def display_board()
        p @board[0]
        puts ""
        p @board[1]
        puts ""
        p @board[2]
    end

    def check_win()
        win=false
        #checks rows
        @board.each do|row|
            return win if win==true
            win=row.uniq.size <= 1 unless row.uniq==[""]
        end

        #checks cols
        @boardcols=@board.transpose()
        @boardcols.each do|row|
            return win if win==true
            win=row.uniq.size <= 1 unless row.uniq==[""]
        end

        #check diag
        
        diag=[@board[0][0],@board[1][1],@board[2][2]]
        diag2=[@board[0][2],@board[1][1],@board[2][0]]
        return win if win==true
        win=diag.uniq.size <= 1 unless diag.uniq==[""]
        return win if win==true
        win=diag2.uniq.size <= 1 unless diag2.uniq==[""]

        return win
    end

    def is_valid?(row,col)
        if row<0 || row>2 || col <0 || col>2
            return false
        end
        return @board[row][col]==""
    end

    def update(row,col,symbol)
        @board[row][col]=symbol
    end
end

def askInput(p)
    puts "#{p.name()} please enter the row number: "
    $row=gets.chomp
    puts "#{p.name()} please enter the col number: "
    $col=gets.chomp
    $row=$row.to_i
    $col=$col.to_i
end

def updateActive(active,p1,p2)
    if active==p1
        return p2
    else;return p1 end
end

class Player
    attr_reader:name
    attr_reader:symbol
    attr_reader:id
    @@id=1
    def initialize()

        puts "Please enter Player #{@@id} name: "
        name=gets.chomp
        puts "Please enter Player #{@@id} symbol: "
        symbol=gets.chomp

        @name=name
        @symbol=symbol
        @@id+=1
    end
    
    


end


def start()
    board=Board.new()
    board.display_board()
    player1=Player.new()
    player2=Player.new()
    active=player1

    while !board.check_win()
        i=false
        while i==false
            askInput(active)
            if board.is_valid?($row,$col)
                board.update($row,$col,active.symbol())
                i=true
            else
                p "invalid input"
            end
        end
        board.display_board()
        active=updateActive(active, player1,player2)
    end
    active=updateActive(active, player1,player2)
    p "#{active.name()} wins"
end

start()
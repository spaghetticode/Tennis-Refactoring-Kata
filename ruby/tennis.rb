# frozen_string_literal: true

class TennisGame1
  def initialize(player1Name, player2Name)
    @players = { player1Name => 0, player2Name => 0 }
  end

  def won_point(playerName)
    @players[playerName] += 1
  end

  def score
    same_score_message || beginning_of_game_message || advantage_or_win_message
  end

  private

  def same_score_message
    if same_score?
      player1_score > 2 ? 'Deuce' : "#{score_text(player1_score)}-All"
    end
  end

  def beginning_of_game_message
    if !same_score? && player1_score < 4 && player2_score < 4
      "#{score_text(player1_score)}-#{score_text(player2_score)}"
    end
  end

  def advantage_or_win_message
    if !same_score? && (player1_score >= 4 || player2_score >= 4)
      player_name = points_difference > 0 ? player1_name : player2_name
      if points_difference.abs == 1
        "Advantage #{player_name}"
      else
        "Win for #{player_name}"
      end
    end
  end

  def points_difference
    player1_score - player2_score
  end

  def same_score?
    player1_score == player2_score
  end

  def player1_name
    @players.keys.first
  end

  def player1_score
    @players.values.first
  end

  def player2_name
    @players.keys.last
  end

  def player2_score
    @players.values.last
  end


  def score_text(score)
    {
      0 => 'Love',
      1 => 'Fifteen',
      2 => 'Thirty',
      3 => 'Forty'
    }[score]
  end
end

class TennisGame2
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == @player1Name
      @p1points += 1
    else
      @p2points += 1
    end
  end

  def score
    if @p1points == @p2points
      if @p1points > 2
        'Deuce'
      else
        "#{score_text(@p1points)}-All"
      end
    else
      result = score_text(@p1points) + '-' + score_text(@p2points)

      if (@p1points > @p2points) && (@p2points >= 3)
        result = 'Advantage ' + @player1Name
      end
      if (@p2points > @p1points) && (@p1points >= 3)
        result = 'Advantage ' + @player2Name
      end
      if @p1points >= 4 && (@p1points - @p2points) >= 2
        result = 'Win for ' + @player1Name
      end
      if @p2points >= 4 && (@p2points - @p1points) >= 2
        result = 'Win for ' + @player2Name
      end
      result
    end
  end

  private

  def score_text(points)
    case points
    when 0 then 'Love'
    when 1 then 'Fifteen'
    when 2 then 'Thirty'
    when 3 then 'Forty'
    else
      ''
    end
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end

  def won_point(n)
    if n == @p1N
      @p1 += 1
    else
      @p2 += 1
    end
  end

  def score
    if ((@p1 < 4) && (@p2 < 4)) && (@p1 + @p2 < 6)
      p = %w[Love Fifteen Thirty Forty]
      s = p[@p1]
      @p1 == @p2 ? s + '-All' : s + '-' + p[@p2]
    else
      if @p1 == @p2
        'Deuce'
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1 - @p2) * (@p1 - @p2) == 1 ? 'Advantage ' + s : 'Win for ' + s
      end
    end
  end
end

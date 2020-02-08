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
      if @p1points < 4 && @p2points < 4
        score_text(@p1points) + '-' + score_text(@p2points)
      else
        if (@p1points - @p2points).abs >= 2
          result = 'Win for '
        else
          result = 'Advantage '
        end
        if (@p1points > @p2points)
          result += @player1Name
        else
          result += @player2Name
        end
      end
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
    @p1Name = player1Name
    @p2Name = player2Name
    @p1Points = 0
    @p2Points = 0
  end

  def won_point(name)
    if name == @p1Name
      @p1Points += 1
    else
      @p2Points += 1
    end
  end

  def score
    if ((@p1Points < 4) && (@p2Points < 4)) && (@p1Points + @p2Points < 6)
      @p1Points == @p2Points ? text(@p1Points) + '-All' : text(@p1Points) + '-' + text(@p2Points)
    else
      if @p1Points == @p2Points
        'Deuce'
      else
        name = @p1Points > @p2Points ? @p1Name : @p2Name
        (@p1Points - @p2Points) * (@p1Points - @p2Points) == 1 ? 'Advantage ' + name : 'Win for ' + name
      end
    end
  end

  private

  def text(points)
  %w[Love Fifteen Thirty Forty][points]
  end
end

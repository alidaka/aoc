#!/usr/bin/env dotnet-script

const string sample = @"R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2";

const string sample2 = @"R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20";

record struct Coordinate(int row, int column)
{
    public Coordinate Right() => this with { column = this.column + 1 };
    public Coordinate Left() => this with { column = this.column - 1 };
    public Coordinate Up() => this with { row = this.row + 1 };
    public Coordinate Down() => this with { row = this.row - 1 };
}

class Grid
{
    Coordinate headPosition;
    List<Coordinate> followers = new();

    public HashSet<Coordinate> VisitedCoordinates = new();

    public Grid()
    {
        headPosition = new(0, 0);

        for (int i = 0; i < 9; i++)
        {
            followers.Add(new(0, 0));
        }

        VisitedCoordinates.Add(followers.Last());
    }

    public void Move(string direction)
    {
        var previousPosition = headPosition;

        // Move the head
        headPosition = direction switch
        {
            "R" => headPosition.Right(),
            "L" => headPosition.Left(),
            "U" => headPosition.Up(),
            "D" => headPosition.Down(),
            _ => throw new InvalidOperationException(),
        };

        var leader = headPosition;
        for (int i = 0; i < followers.Count; i++)
        {
            var positionBeforeMove = followers[i];
            if (ShouldMove(leader, followers[i]))
            {
                followers[i] = previousPosition;
            }

            // TODO bug: instead of following previous position,
            // need to ensure we prioritize moving diagonally
            leader = followers[i];
            previousPosition = positionBeforeMove;
        }

        VisitedCoordinates.Add(followers.Last());
    }

    private static bool ShouldMove(Coordinate leader, Coordinate follower)
    {
        var horizontalDelta = leader.row - follower.row;
        var verticalDelta = leader.column - follower.column;
        return Math.Abs(horizontalDelta) > 1 || Math.Abs(verticalDelta) > 1;
    }
}

var grid = new Grid();
foreach (var line in sample2.Split('\n').ToList())
// foreach (var line in File.ReadLines("09.txt"))
{
    var words = line.Split(' ');
    var direction = words[0];
    var steps = int.Parse(words[1]);

    for (int i = 0; i < steps; i++)
    {
        grid.Move(direction);
    }
}

Console.WriteLine(grid.VisitedCoordinates.Count);
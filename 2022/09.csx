#!/usr/bin/env dotnet-script

const string sample = @"R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2";

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
    Coordinate tailPosition;

    public HashSet<Coordinate> VisitedCoordinates = new();

    public Grid()
    {
        headPosition = new(0, 0);
        tailPosition = new(0, 0);

        VisitedCoordinates.Add(tailPosition);
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

        // Make the tail follow
        var horizontalDelta = headPosition.row - tailPosition.row;
        var verticalDelta = headPosition.column - tailPosition.column;

        var tooFar = Math.Abs(horizontalDelta) > 1 || Math.Abs(verticalDelta) > 1;
        if (tooFar)
        {
            tailPosition = previousPosition;
            VisitedCoordinates.Add(tailPosition);
        }
    }
}

var grid = new Grid();
//foreach (var line in sample.Split('\n').ToList())
foreach (var line in File.ReadLines("09.txt"))
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
#!/usr/bin/env dotnet-script


interface Shape
{
    public int Value { get; }
}

class Rock : Shape
{
    public int Value => 1;
}

class Paper : Shape
{
    public int Value => 2;
}

class Scissors : Shape
{
    public int Value => 3;
}

var shapes = new Shape[]
{
    new Scissors(),
    new Rock(),
    new Paper(),
    new Scissors(),
    new Rock(),
};

var score = File.ReadLines("02.txt").Sum(line =>
{
    var words = line.Split(" ");
    var themIndex = words[0][0] - 'A' + 1;

    switch (words[1])
    {
        case "X":
            // Loss
            return shapes[themIndex - 1].Value;

        case "Y":
            // Draw
            return 3 + shapes[themIndex].Value;

        case "Z":
            // Win
            return 6 + shapes[themIndex + 1].Value;

        default: throw new InvalidOperationException();
    }
});

Console.WriteLine(score);

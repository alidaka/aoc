#!/usr/bin/env dotnet-script

enum Outcome
{
    Draw,
    Loss,
    Win,
}

interface Shape
{
    public Outcome Plays(Shape other);
    public int Value { get; }

    public static Shape From(string s) => s switch
    {
        "A" or "X" => new Rock(),
        "B" or "Y" => new Paper(),
        "C" or "Z" => new Scissors(),
        _ => throw new ArgumentException(),
    };
}

class Rock : Shape
{
    public int Value => 1;
    public Outcome Plays(Shape other) => other switch
    {
        Rock _ => Outcome.Draw,
        Paper _ => Outcome.Loss,
        Scissors _ => Outcome.Win,
    };
}

class Paper : Shape
{
    public int Value => 2;
    public Outcome Plays(Shape other) => other switch
    {
        Rock _ => Outcome.Win,
        Paper _ => Outcome.Draw,
        Scissors _ => Outcome.Loss,
    };
}

class Scissors : Shape
{
    public int Value => 3;
    public Outcome Plays(Shape other) => other switch
    {
        Rock _ => Outcome.Loss,
        Paper _ => Outcome.Win,
        Scissors _ => Outcome.Draw,
    };
}

int Score(Shape them, Shape me)
{
    var score = me.Plays(them) switch
    {
        Outcome.Win => 6,
        Outcome.Draw => 3,
        Outcome.Loss => 0,
    };

    return score + me.Value;
}

var score = 0;
foreach (var line in File.ReadLines("02.txt"))
{
    var shapes = line.Split(" ");
    var them = Shape.From(shapes[0]);
    var me = Shape.From(shapes[1]);

    score += Score(them, me);
}

Console.WriteLine(score);

#!/usr/bin/env dotnet-script

class CleaningRange
{
    int Start;
    int End;

    public CleaningRange(string s)
    {
        var bounds = s.Split('-');
        Start = int.Parse(bounds[0]);
        End = int.Parse(bounds[1]);
    }

    public bool Contains(CleaningRange other) =>
        Start <= other.Start && End >= other.End;

    public bool Overlaps(CleaningRange other) =>
        Start <= other.End && End >= other.Start;
}

var x = File.ReadLines("04.txt")
    .Where(line =>
    {
        var ranges = line.Split(',').Select(s => new CleaningRange(s));;
        //return ranges.First().Contains(ranges.Last()) || ranges.Last().Contains(ranges.First());
        return ranges.First().Overlaps(ranges.Last());
    })
    .Count();

Console.WriteLine(x);

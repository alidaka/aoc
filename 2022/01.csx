#!/usr/bin/env dotnet-script

var elves = new List<int>();
elves.Add(0);
foreach (var line in File.ReadLines("01.txt"))
{
    if (string.IsNullOrWhiteSpace(line))
    {
        elves.Add(0);
    }
    else
    {
        var calories = int.Parse(line);
        elves[^1] = elves[^1] + calories;
    }
}

Console.WriteLine($"Max cal elf: {elves.Max()}");

elves.Sort();
var maxThree = elves.ToArray()[^3..^0];
Console.WriteLine($"Max three elves: {maxThree.Sum()}");

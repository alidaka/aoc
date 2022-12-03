#!/usr/bin/env dotnet-script

HashSet<char> TallyCompartment(string items)
{
    var compartment = new HashSet<char>();
    foreach (var c in items)
    {
        compartment.Add(c);
    }

    return compartment;
}

var priority = File.ReadLines("03.txt")
    .Chunk(3)
    .Sum(bags =>
    {
        var tallies = bags.Select(b => TallyCompartment(b)).ToArray();
        var badge = tallies[0].Intersect(tallies[1]).Intersect(tallies[2]).First();;

        return badge < 'a'
            ?  27 + badge - 'A'
            : 1 + badge - 'a';
    });

Console.WriteLine(priority);

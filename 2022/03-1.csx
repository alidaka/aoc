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

(HashSet<char> c1, HashSet<char> c2) TallyBag(string line)
{
    return (TallyCompartment(line[..(line.Length/2)]), TallyCompartment(line[(line.Length/2)..]));
}

var priority = File.ReadLines("03.txt").Sum(line =>
    {
        var (c1, c2) = TallyBag(line);
        var common = c1.Intersect(c2).First();

        return common < 'a'
            ?  27 + common - 'A'
            : 1 + common - 'a';
    });

Console.WriteLine(priority);

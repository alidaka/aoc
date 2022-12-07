#!/usr/bin/env dotnet-script

Console.WriteLine(default(char));

var line = File.ReadLines("06.txt").First();
const int markerLength = 14;
var chars = new char[markerLength];
for (int i = 0; i < line.Length; i++)
{
    var c = line[i];
    if (chars[i%markerLength] == default(char))
    {
        chars[i] = c;
        continue;
    }

    var set = new HashSet<char>(chars);
    if (set.Count == markerLength)
    {
        Console.WriteLine(i);
        break;
    }

    chars[i%markerLength] = c;
}

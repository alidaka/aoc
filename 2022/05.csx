#!/usr/bin/env dotnet-script

var lines = File.ReadLines("05.txt")
    .ToList();

List<Stack<char>> stacks = Enumerable.Range(1, 9)
    .Select(_ => new Stack<char>())
    .ToList();

int index = 0;
var line = lines[0];
while (line[1] != '1')
{
    // Each chunk will be like "[A] ", except the last with no trailing space
    var stackIndex = 0;
    line.Chunk(4)
        .ToList()
        .ForEach(chars =>
        {
            if (chars[1] != ' ')
            {
                stacks[stackIndex].Push(chars[1]);
            }

            stackIndex++;
        });

    index++;
    line = lines[index];
}

// Stacks were created top-down, which is reverse order
stacks = stacks.Select(s => new Stack<char>(s))
    .ToList();

// Skip the next whitespace newline
index++;
index++;

while (index != lines.Count)
{
    line = lines[index];

    var words = line.Split(' ');

    var count = int.Parse(words[1]);
    // They are 1-indexed, we are 0
    var from = int.Parse(words[3]) - 1;
    var to = int.Parse(words[5]) - 1;

    var chunk = new List<char>();
    for (var i = 0; i < count; i++)
    {
        chunk.Add(stacks[from].Pop());
    }

    foreach (var c in ((IEnumerable<char>)chunk).Reverse())
    {
        stacks[to].Push(c);
    }

    index++;
}

var result = string.Concat(stacks.Select(s => s.Pop()));
Console.WriteLine(result);
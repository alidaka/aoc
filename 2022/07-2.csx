#!/usr/bin/env dotnet-script

class Reader
{
    public string Current;

    List<string> lines = System.IO.File.ReadLines("07.txt").ToList();
    int index = 0; 
    public Reader()
    {
        Current = lines[index];
    }

    public string Advance()
    {
        if (index >= lines.Count - 1)
        {
            return Current = string.Empty;
        }

        return Current = lines[++index];
    }
}

abstract record Node(string Name)
{
    public int Size { get; protected set; }
}

record Dir(string Name) : Node(Name)
{
    public List<Dir> Children = new();
    public List<File> Files = new();
    public Dir Parent;

    public void AddChild(Node node)
    {
        switch (node)
        {
            case File file:
                Files.Add(file);
                AddDescendent(file.Size);
                break;

            case Dir dir:
                Children.Add(dir);
                dir.Parent = this;
                break;

            default:
                throw new InvalidOperationException();
        }
    }

    private void AddDescendent(int size)
    {
        Size += size;
        if (Parent != null)
        {
            Parent.AddDescendent(size);
        }
    }
}

record File : Node
{
    public File(string name, int size) : base(name)
    {
        Size = size;
    }
}

// A poor state machine
var reader = new Reader();
var root = new Dir("/");
var current = root;
reader.Advance();
while (reader.Current != string.Empty)
{
    var words = reader.Current.Split(' ');
    if (words[0][0] == '$')
    {
        switch (words[1])
        {
            case "cd":
                current = words[2] == ".."
                    ? current.Parent
                    : current.Children.Single(d => d.Name == words[2]);
                reader.Advance();
                continue;

            case "ls":
                reader.Advance();
                continue;

            default: throw new InvalidOperationException();
        }
    }
    else
    {
        Node node = words[0] switch
        {
            "dir" => new Dir(words[1]),
            _ => new File(words[1], int.Parse(words[0])),
        };

        current.AddChild(node);
        reader.Advance();
    }
}

const int capacity = 70000000;
const int needed = 30000000;
var gap = needed - (capacity - root.Size);
var candidates = new List<Dir> { root };
Action<Dir> foo = (Dir dir) =>
{
    foreach (var child in dir.Children)
    {
        if (child.Size >= gap)
        {
            candidates.Add(child);
            foo(child);
        }
    }
};
foo(root);

var answer = candidates.OrderBy(d => d.Size).First();

Console.WriteLine($"{answer.Name}: {answer.Size}");
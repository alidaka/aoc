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
    public int ExclusiveSize { get; protected set; }
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
                ExclusiveSize += file.Size;
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

    public int SumBelowThreshold(int threshold)
    {
        var acc = 0;
        if (Size < threshold)
        {
            acc += Size;
        }

        return acc + Children.Select(c => c.SumBelowThreshold(threshold)).Sum();
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

Console.WriteLine(root.SumBelowThreshold(100000));
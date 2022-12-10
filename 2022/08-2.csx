#!/usr/bin/env dotnet-script

const string sample = @"30373
25512
65332
33549
35390";

class Forest
{
    int[,] trees;
    int rows;
    int columns;

    public Forest()
    {
        // var lines = sample.Split('\n').ToList();
        var lines = File.ReadLines("08.txt").ToList();
        for (int i = 0; i < lines.Count; i++)
        {
            var line = lines[i];
            if (trees == null)
            {
                rows = lines.Count;
                columns = line.Length;
                trees = new int[rows, columns];
            }

            for (int j = 0; j < line.Length; j++)
            {
                trees[i, j] = line[j] - '0';
            }
        }
    }

    public int MaxScenicScore()
    {
        var scores = CalculateScenicScores();

        // Ignore trees on the edge (viewing distance 0)
        var max = -1;
        for (int i = 1; i < rows - 1; i++)
        {
            for (int j = 1; j < columns - 1; j++)
            {
                max = Math.Max(max, scores[i, j]);
            }
        }

        return max;
    }

    private int[,] CalculateScenicScores()
    {
        var scores = new int[rows, columns];

        // init
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < columns; j++)
            {
                scores[i, j] = 1;
            }
        }

        // left
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < columns; j++)
            {
                var distance = 1;
                var k = j + 1;
                while (k < columns - 1 && trees[i, j] > trees[i, k])
                {
                    distance++;
                    if (trees[i, j] == trees[i, k]) break;
                    k++;
                }

                scores[i, j] = scores[i, j] * distance;
            }
        }

        // right
        for (int i = 0; i < rows; i++)
        {
            for (int j = columns - 1; j >= 0; j--)
            {
                var distance = 1;
                var k = j - 1;
                while (k >= 1 && trees[i, j] > trees[i, k])
                {
                    distance++;
                    if (trees[i, j] == trees[i, k]) break;
                    k--;
                }

                scores[i, j] = scores[i, j] * distance;
            }
        }

        // down
        for (int j = 0; j < columns; j++)
        {
            for (int i = 0; i < rows; i++)
            {
                var distance = 1;
                var k = i + 1;
                while (k < rows - 1 && trees[i, j] > trees[k, j])
                {
                    distance++;
                    if (trees[i, j] == trees[k, j]) break;
                    k++;
                }

                scores[i, j] = scores[i, j] * distance;
            }
        }

        // up
        for (int j = 0; j < columns; j++)
        {
            for (int i = rows - 1; i >= 0; i--)
            {
                var distance = 1;
                var k = i - 1;
                while (k >= 1 && trees[i, j] > trees[k, j])
                {
                    distance++;
                    if (trees[i, j] == trees[k, j]) break;
                    k--;
                }

                scores[i, j] = scores[i, j] * distance;
            }
        }

        return scores;
    }
}

var forest = new Forest();
Console.WriteLine(forest.MaxScenicScore());
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
        //var lines = sample.Split('\n').ToList();
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

    public int CountVisible()
    {
        var visibility = CalculateVisibility();
        var count = 0;
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < columns; j++)
            {
                if (visibility[i, j])
                {
                    count++;
                }
            }
        }

        return count;
    }

    private bool[,] CalculateVisibility()
    {
        var visibility = new bool[rows, columns];

        // init - all start as false (invisible)
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < columns; j++)
            {
                visibility[i, j] = false;
            }
        }

        // left
        for (int i = 0; i < rows; i++)
        {
            var max = -1;
            for (int j = 0; j < columns; j++)
            {
                if (trees[i, j] > max)
                {
                    max = trees[i, j];
                    visibility[i, j] = true;
                }
            }
        }

        // right
        for (int i = 0; i < rows; i++)
        {
            var max = -1;
            for (int j = columns - 1; j >= 0; j--)
            {
                if (trees[i, j] > max)
                {
                    max = trees[i, j];
                    visibility[i, j] = true;
                }
            }
        }

        // down
        for (int j = 0; j < columns; j++)
        {
            var max = -1;
            for (int i = 0; i < rows; i++)
            {
                if (trees[i, j] > max)
                {
                    max = trees[i, j];
                    visibility[i, j] = true;
                }
            }
        }

        // up
        for (int j = 0; j < columns; j++)
        {
            var max = -1;
            for (int i = rows - 1; i >= 0; i--)
            {
                if (trees[i, j] > max)
                {
                    max = trees[i, j];
                    visibility[i, j] = true;
                }
            }
        }

        return visibility;
    }
}

var forest = new Forest();
Console.WriteLine(forest.CountVisible());
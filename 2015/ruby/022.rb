def sa_of_box(dim_string)
  dims = dim_string.split('x').map(&:to_i).sort
  faces = dims.combination(2).to_a
  surface_area = faces.inject(0) do |acc, face|
    area = face[0] * face[1]
    acc + (2 * area)
  end

  surface_area + faces[0][0] * faces[0][1]
end

values = ARGV[0].split("\n")
puts values.inject(0){|acc, box| acc + sa_of_box(box)}

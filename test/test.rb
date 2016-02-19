#!/usr/bin/env ruby

class Problem
  attr_accessor(:file, :test_cases)
end

def parse_language
  language = Dir.pwd.split('/').last
  case language
  when 'ruby'
    extension = 'rb'
    runner = 'ruby'
  when 'haskell'
    extension = 'hs'
    runner = 'runhaskell'
  else
    STDERR.puts "#{__FILE__} must be run from one of the language-specific subdirectories"
    exit 1
  end

  [language, extension, runner]
end

def basename(day, part)
  "%02d%d" % [day, part]
end

def create_problems(argv, extension)
  case argv.size
  when 2
    days = [argv[0].to_i]
    parts = [argv[1].to_i]
  when 1
    days = argv[0].to_i
    parts = [1,2]
  else
    days = (1..25).to_a
    parts = [1,2]
  end

  create_problems_inner(days, parts, extension)
end

def create_problems_inner(days, parts, extension)
  days.each_with_object([]) do |day, memo|
    parts.each do |part|
      basename = basename(day, part)
      filename = "%s.%s" % [basename, extension]
      test_dir = File.dirname(__FILE__)
      test_cases_file = File.join(test_dir, basename + ".rb")

      if File.exist?(filename)
        if File.exists?(test_cases_file)
          # TODO: eval kind of sucks
          test_cases = eval(File.open(test_cases_file).read)
          if test_cases && !test_cases.empty?
            problem = Problem.new
            problem.file = filename
            problem.test_cases = test_cases
            memo << problem
          else
            STDOUT.puts "#{filename} exists but have no test cases!"
          end
        else
          STDOUT.puts "#{filename} exists but have no test cases!"
        end
      end

    end
  end
end

def run(runner, problem)
  problem.test_cases.each do |input, expected|
    actual = `#{runner} #{problem.file} "#{input}"`.strip
    unless actual == expected
      STDERR.puts 'Failure!'
      STDERR.puts "For #{problem.file}, input:"
      STDERR.puts input
      STDERR.puts 'Expected:'
      STDERR.puts expected
      STDERR.puts 'Actual:'
      STDERR.puts actual
      exit 1
    end
  end
end


############
language, extension, runner = parse_language
puts "Detected language #{language}"

problems = create_problems(ARGV, extension)
puts "Files: #{problems.collect{|p| p.file}}"

problems.each {|problem| run(runner, problem)}

puts 'All pass'

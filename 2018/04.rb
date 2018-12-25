#!/usr/bin/env ruby

def strategy1(string)
  string.each_line
    .map(&Event.method(:new))
    .each_entry do |event|
      if event.time > 23 then
        event.time = 0
        event.day += 1
      end
    end
    .group_by(&:day)
    .map(&Shift.method(:new))
end

class Shift
  attr_reader :guard, :sleeps

  def initialize(events)
    # append a fake "wakes up" event at 1:01?
    events.sort_by { |event| event.time }
      .each_entry do |event|
        case event.payload
        when /falls/
        when /wakes/
        when /Guard #(\d+)/
          @guard = $1
        end
      end
  end
end

class Event
  attr_accessor :day, :time
  attr_reader :payload

  def initialize(string)
    timestamp, payload = string.split(']')
    day, time = timestamp.split
    @day = day.gsub(/[\[\-]/, '').to_i
    @time = time.gsub(':', '').to_i
    @payload = payload.strip
  end
end

if __FILE__ == $0
  if ARGV.empty?
    require 'minitest/autorun'

    class Test < Minitest::Test
      def test_part_one
        input = <<~HEREDOC
          [1518-11-01 00:05] falls asleep
          [1518-11-01 00:00] Guard #10 begins shift
          [1518-11-01 00:25] wakes up
          [1518-11-01 00:30] falls asleep
          [1518-11-01 00:55] wakes up
          [1518-11-01 23:58] Guard #99 begins shift
          [1518-11-02 00:40] falls asleep
          [1518-11-02 00:50] wakes up
          [1518-11-03 00:05] Guard #10 begins shift
          [1518-11-03 00:24] falls asleep
          [1518-11-03 00:29] wakes up
          [1518-11-04 00:02] Guard #99 begins shift
          [1518-11-04 00:36] falls asleep
          [1518-11-04 00:46] wakes up
          [1518-11-05 00:03] Guard #99 begins shift
          [1518-11-05 00:45] falls asleep
          [1518-11-05 00:55] wakes up
        HEREDOC

        assert_equal(240, strategy1(input))
      end

      def test_part_two
      end
    end
  else
    p strategy1 *ARGV
  end
end

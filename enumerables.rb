#!/usr/bin/ruby
# frozen_string_literal: true

# rubocop:disable ModuleLength
# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    if block_given?
      (0...size).each do |i|
        yield(self[i])
      end
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      (0...size).each do |i|
        yield(self[i], i)
      end
    else
      to_enum
    end
  end

  def my_select
    if block_given?
      if instance_of?(Array)
        temp_array = []
        my_each do |item|
          temp_array << item if yield(item)
        end
        temp_array
      end
    else
      to_enum
    end
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |x| return false unless yield x }
    else
      return my_all? { |obj| obj } unless pattern

      if pattern.class == Regexp
        my_each { |x| return false unless pattern.match?(x) }
      elsif pattern.class == Class
        my_each { |x| return false unless x.is_a? pattern }
      else
        my_each { |x| return false unless x == pattern }
      end
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |x| return true unless yield x }
    else
      return my_all? { |obj| obj } unless pattern

      if pattern.class == Regexp
        my_each { |x| return true unless pattern.match?(x) }
      elsif pattern.class == Class
        my_each { |x| return true unless x.is_a? pattern }
      else
        my_each { |x| return true unless x == pattern }
      end
    end
    false
  end

  def my_none?
    if block_given?
      !my_any? { |x| yield x }
    elsif pattern
      !my_any?(pattern)
    else
      my_each { |x| return false if x }
      true
    end
  end

  def my_count(args = nil)
    count = 0
    if block_given?
      my_each { |x| count += 1 if yield x }
    elsif args
      my_each { |x| count += 1 if x == args }
    else
      my_each { count += 1 }
    end
    count
  end

  def my_inject(*_item)
    acc = self[0]
    self[1..length].each do |x|
      acc = yield(acc, x)
    end
    acc
  end

  def multiply_els(arr)
    arr.my_inject { |n, p| n * p }
  end

  def my_map
    if block_given?
      result = []
      (1..size).each { |n| result << yield(n) } if self.class == Range
      (0...size).each { |n| result << yield(self[n].to_i) } if self.class != Range
      (0...size).each { |n| result << yield(self[n].to_i) } if self.class == Proc
      result
    else
      to_enum
    end
  end
end
# rubocop:enable ModuleLength
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

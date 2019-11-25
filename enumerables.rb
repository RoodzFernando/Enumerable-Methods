#!/usr/bin/ruby
# frozen_string_literal: true

# rubocop:disable ModuleLength

module Enumerable
  # my_each
  def my_each
    if block_given?
      (0...size).each do |i|
        yield(self[i])
      end
    else
      to_enum
    end
  end

  # my_each_with_index

  def my_each_with_index
    if block_given?
      (0...size).each do |i|
        yield(self[i], i)
      end
    else
      to_enum
    end
  end

  # my_select

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

  # my_all?

  def my_all?
    if block_given?
      temp_array = []
      my_each do |item|
        temp_array << yield(item)
      end
      (0...temp_array.size).each do |i|
        return true if temp_array[i] == true

        return false
      end
    else
      to_enum
    end
  end

  # my_any?

  def my_any?
    if block_given?
      temp_array = []
      my_each do |item|
        temp_array << yield(item)
      end
      (0...temp_array.size).each do |i|
        return true if temp_array[i] == true || temp_array.nil?
      end
    else
      true
    end
  end

  # my_none?

  def my_none?
    if block_given?
      temp_array = []
      my_each do |item|
        temp_array << yield(item)
      end
      (0...temp_array.size).each do |i|
        return true if temp_array[i] == false || temp_array.nil?
      end
    else
      true
    end
  end

  # my_count

  def my_count
    if instance_of?(Array)
      temp_array = []
      my_each do |item|
        temp_array << item if yield(item)
      end
      temp_array.size
    end
    return unless block_given?
  end

  # my_map

  # def my_map(&block)
  #    if block_given?
  #         temp_array = []
  #         self.my_each do |item|
  #             temp_array << block.call(item)
  #         end
  #         temp_array
  #         else
  #         self.to_enum
  #     end
  # end

  # my_inject

  def my_inject(param = nil)
    if block_given?
      if param.nil?
        result = shift
        my_each_with_index do |_, index|
          result = yield(result, self[index])
        end
        return result
      else
        result = 0
        i = param
        (i...size).each do |n|
          result = yield(result, self[n])
        end
      end
    else
      puts 'No block given'
    end
    result
  end

  # mutiply_els

  def multiply_els(arr)
    arr.my_inject { |n, p| n * p }
  end

  # modified my_map enumerable

  def my_map(arr, proc = nil)
    result = []

    i = 0
    while i < arr.length
      if block_given?
        yield(arr[i])
      else
        result << proc.call(arr[i])
      end
      i += 1
    end
    result
  end
end
# rubocop:enable ModuleLength

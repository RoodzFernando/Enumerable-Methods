#!/usr/bin/ruby

module Enumerable
    # my_each
    def my_each
        if block_given?
            for i in 0...self.size
            yield(self[i])
            end
        else
            self.to_enum
        end
    end

    #my_each_with_index 

    def my_each_with_index
        if block_given?
            for i in 0...self.size 
            yield(self[i],i)
            end
        else
            self.to_enum
        end
    end

    #my_select

    def my_select
        
        if block_given?
            if self.instance_of?(Array)
            temp_array = []
            self.my_each do |item|
                temp_array << item if yield(item)
            end
            temp_array
            end
        else
            self.to_enum
        end
    end

    #my_all?

    def my_all?
        if block_given?
            temp_array = []
            self.my_each do |item|
                temp_array << yield(item)
            end
            for i in 0...temp_array.size
             if temp_array[i] == true
                return  true
             else
                return false
             end
            end
        else
            self.to_enum
        end
    end

    # my_any?

    def my_any?
        if block_given?
            temp_array = []
            self.my_each do |item|
                temp_array << yield(item)
            end
            for i in 0...temp_array.size
                if temp_array[i] == true || temp_array.nil?
                    return  true
                end
            end
        else
            return true
        end
    end

    #my_none?

    def my_none?
        if block_given?
             temp_array = []
        self.my_each do |item|
            temp_array << yield(item)
        end
        for i in 0...temp_array.size
             if temp_array[i] == false || temp_array.nil?
                return  true
             end
        end
        else
            return true
        end
    end

    # my_count

    def my_count
        if block_given?
            if self.instance_of?(Array)
            temp_array = []
            self.my_each do |item|
                temp_array << item if yield(item)
            end
            temp_array.size
            end
        else
            count = self.size
        end
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
            result = self.shift
            i = 0
            self.my_each_with_index do |_, index|
                result = yield(result, self[index])
            end
            return result
        else
            result = 0
            i = param
            for i in i...self.size do
              result = yield(result, self[i])
            end
        end
        else
          puts 'No block given'
        end
        result
    end

    # mutiply_els

    def multiply_els(arr)
        arr.my_inject{|n, p| n * p}
    end

    # modified my_map enumerable

    def my_map(arr, proc=nil)
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
        return result
    end
end
    

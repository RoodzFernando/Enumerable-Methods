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
        
        if self.instance_of?(Array)
            temp_array = []
            self.my_each do |item|
                temp_array << item if yield(item)
            end
            temp_array
        end
    end

    #my_all?

    def my_all?
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
    end

    # my_any?

    def my_any?
        temp_array = []
        self.my_each do |item|
            temp_array << yield(item)
        end
        for i in 0...temp_array.size
             if temp_array[i] == true || temp_array.nil?
                return  true
             end
        end
    end

    
end


# puts ["hey", "hey", "hey"].my_all?{|n| n.length == 3}
puts [4, 2, 3].my_any?{|n| n == 4}



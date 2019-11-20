#!/usr/bin/ruby

module Enumerable
    # my_each
    def my_each
        for i in 0..self.size-1
            yield(self[i])
        end
    end

end

[4, 3, 2, 1, 5, 25, 14, 28].my_each{|n| puts n}

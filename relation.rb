## who is the committer
# All submissions for this problem are available.

# Let A be a set of the first N positive integers :A={1,2,3,4.........N}

# Let B be the set containing all the subsets of A.
# Professor Eric is a mathematician who defined two kind of relations R1 and R2 on set B.

# The relations are defined as follows:
# R1={ (x,y) : x and y belong to B and x is not a subset of y and y is not a subset of x and the intersection of x and y is equal to empty set }
# R2={ (x,y) : x and y belong to B and x is not a subset of y and y is not a subset of x and the intersection of x and y is not equal to empty set }
# Now given the number N,Professor Eric wants to know how many relations of kind R1 and R2 exists.Help him.
# NOTE : (x,y) is the same as (y,x) ,i.e the pairs are unordered.
# Input format:

# The first line contains the number of test cases T.Each of the test case is denoted by a single integer N.
# Output format:

# Output T lines, one for each test case,containing two integers denoting the number of relations of kind R1 and R2 respectively, modulo 100000007.
# Example

# Sample Input:
# 3
# 1
# 2
# 3
# Sample Output:
# 0 0
# 1 0
# 6 3
# Constraints:
# 1 <= T <= 1000
# 1 <= N <= 10^18
# Explanation:
# Let A={1,2}
# Then B={Phi,{1},{2},{1,2}}
# Phi=Empty Set
# So R1=Either {({1},{2})} or {({2},{1})}
# and R2=No relation exists
# So,there is 1 relation of kind R1 and 0 relation of kind R2.


require 'rubygems'
require 'set'
require 'pry'
require 'benchmark'
class TestCase
  attr_reader :numbers,:sets
  def initialize(numbers)
    @numbers = numbers.sort
    @sets = []
    create_sets
  end

  def relation1
    sets.combination(2).inject(0) do |sum,setarry|
      if for_relation1?(*setarry)
        sum += 1
      end
      sum
    end
  end

  def relation2

    sets.combination(2).inject(0) do |sum,setarry|
      if for_relation2?(*setarry)
        sum += 1
      end
      sum
    end
  end

  private
  def for_relation1?(set1,set2)
    !set1.subset?(set2) and !set2.subset?(set1) and set1.intersection(set2).empty?
  end

  def for_relation2?(set1,set2)
     !set1.subset?(set2) and !set2.subset?(set1) and set1.intersection(set2).any?
  end

  def create_sets
    sets = []
    (numbers.count+1).times do |time|
      sets.push(combination(time))
    end
    @sets = sets.flatten
  end

  def combination(time)
    numbers.combination(time).map do |i|
      Set.new(i)
    end.flatten
  end
end

input = gets().to_i
numbers = []
test_cases = []
input.times do |i|
  number = gets().to_i
  numbers.push(number)
  test_cases.push(TestCase.new(numbers.dup))
end

#Benchmark.measure do |i|
  test_cases.each do |test_case|
    puts test_case.relation1.to_s + "  " + test_case.relation2.to_s
  end
#end

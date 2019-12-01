numbers = File.read("input").scan(/\d+/).map { |md| md[0].to_i }

class Traverser
  @index = 0
  getter sum = 0
  @depth = 0

  def initialize(@numbers : Array(Int32))
  end

  def traverse
    num_of_child_nodes = @numbers[@index]
    num_of_metadata_entries = @numbers[@index + 1]
    @index += 2

    (0...num_of_child_nodes).each do |_|
      @depth += 1
      traverse
      @depth -= 1
    end
    @sum += (@index...@index + num_of_metadata_entries).map { |i| @numbers[i] }.sum
    @index += num_of_metadata_entries
  end
end

traverser = Traverser.new(numbers)
traverser.traverse
puts traverser.sum

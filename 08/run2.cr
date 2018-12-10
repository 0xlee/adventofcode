numbers = File.read("input").scan(/\d+/).map { |md| md[0].to_i }

class Traverser
  @index = 0

  def initialize(@numbers : Array(Int32))
  end

  def traverse : Int32
    num_of_child_nodes = @numbers[@index]
    num_of_metadata_entries = @numbers[@index + 1]
    @index += 2

    values = (0...num_of_child_nodes).map do |i|
      traverse.as(Int32)
    end
    sum = (@index...@index + num_of_metadata_entries).map { |i| @numbers[i] }.sum

    result = if num_of_child_nodes > 0
               (0...num_of_metadata_entries)
                 .map { |i| @numbers[@index + i] }
                 .select { |v| v <= num_of_child_nodes }
                 .map { |v| values[v - 1] }
                 .sum
             else
               sum
             end
    @index += num_of_metadata_entries
    result
  end
end

traverser = Traverser.new(numbers)
puts traverser.traverse

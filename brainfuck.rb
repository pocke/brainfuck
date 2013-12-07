class BrainFuck
  def initialize(program)
    @byte = Hash.new(0)
    @ptr = 0
    @program = program
  end

  def run
    now = 0
    while @program[now] do
      case @program[now]
      when '>' then
        @ptr += 1
      when '<' then
        @ptr -= 1
      when '+' then
        @byte[@ptr] = (@byte[@ptr] + 1) % 256
      when '-' then
        @byte[@ptr] = (@byte[@ptr] - 1) % 256
      when '.' then
        putc @byte[@ptr]
      when ',' then
        @byte[@ptr] = STDIN.getbyte
      when '[' then
        if @byte[@ptr] == 0 then
          s = 0
          loop do
            now += 1
            if @program[now] == ']' then
              break if s == 0
              s -= 1
            elsif @program[now] == '[' then
              s += 1
            end
          end
        end
      when ']' then
        s = 0
        loop do
          now -= 1
          if @program[now] == '[' then
            break if s == 0
            s -= 1
          elsif @program[now] == ']' then
            s += 1
          end
        end
        now -= 1
      end
      now += 1
    end
  end
end

b = BrainFuck.new File.open(ARGV[0]).read.chomp
b.run

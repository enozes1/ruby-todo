class TodoList
  def initialize
    @tasks = []
  end

  def add(task)
    @tasks << { name: task, completed: false }
    puts "Added task."
  end

  def view
    puts "\nTo-Do List:"
    if @tasks.empty?
      puts "Your to-do list is empty."
    else
      @tasks.each_with_index do |task, index|
        status = task[:completed] ? "[X]" : "[ ]"
        puts "#{index + 1}. #{status} #{task[:name]}"
      end
    end
  end

  def mark_complete(index)
    if index > 0 && index <= @tasks.length
      @tasks[index - 1][:completed] = true
      puts "Completed: \"#{@tasks[index - 1][:name]}\""
    else
      puts "Invalid task number."
    end
  end

  def delete(index)
    if index > 0 && index <= @tasks.length
      deleted_task = @tasks.delete_at(index - 1)
      puts "Deleted: \"#{deleted_task[:name]}\""
    else
      puts "Invalid task number."
    end
  end
end

def main
  todo_list = TodoList.new
  puts "Welcome to ruby To-Do List!"
  puts "Commands: + <task>, o (open), c <number>, - <number>, e (exit)"

  loop do
    print "\n> "
    input = gets.chomp
    command, argument = input.split(' ', 2)

    case command
    when '+'
      if argument && !argument.strip.empty?
        todo_list.add(argument)
      else
        puts "Error: Please provide a task to add. Example: + Buy milk"
      end
    when 'o'
      todo_list.view
    when 'c'
      if argument && argument.match?(/^\d+$/)
        todo_list.mark_complete(argument.to_i)
      else
        puts "Error: Please provide a task number. Example: c 1"
      end
    when '-'
      if argument && argument.match?(/^\d+$/)
        todo_list.delete(argument.to_i)
      else
        puts "Error: Please provide a task number. Example: - 2"
      end
    when 'e'
      puts "Goodbye!"
      break
    when nil
      next
    else
      puts "Invalid command '#{command}'. Use: +, o, c, -, or exit."
    end
  end
end

main

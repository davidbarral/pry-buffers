if ENV['HOME'].nil?
  Pry.output.puts 'WARNING: pry-buffers plugin requires the HOME envronment variable to be set. Plugin not active'
else

  require 'fileutils'

  $pry_bufs =  File.join ENV['HOME'], '.pry_bufs'

  FileUtils.mkdir_p $pry_bufs
  FileUtils.touch File.join($pry_bufs, 'default') unless File.exists?(File.join($pry_bufs, 'default'))

  Pry.config.commands.command "buf", "Use and manage temporary buffers to execute arbitrary code" do |*args|

    opts = Slop.parse!(args) do |opt|
      opt.banner unindent <<-USAGE
        Usage: buf [-l|-s|-d|-h] <BUFFER>
        Open a text editor and evaluate its content upon close. When no buffer
        is given, the "default" buffer is used by default. You can show or
        delete the contents of a given buffer or list all the stored buffers.
        e.g: buf
             buf test
             buf -d test
             buf -s test
             buf -l
             buf -h
      USAGE

      opt.on :s, :show,    "show the contents of the buffer"
      opt.on :d, :delete,  "clears the given buffer"
      opt.on :l, :list,    "List all the stored buffers"
      opt.on :h, :help,    "This message"
    end

    if [opts.s?, opts.d?, opts.l?, opts.h?].count(true) > 1
      output.puts "Error: -s,-d,-l and -h options are incompatible"

    elsif (opts.d? || opts.s?) && args.empty?
      output.puts "Error: -d|-s options need one argument"

    elsif opts.l? && !args.empty?
      output.puts "Error: -l must be used without arguments"

    elsif args.length > 1
      output.puts "Error: can only use one buffer at a time"

    elsif opts.h?
      output.puts opts

    elsif opts.l?
      output.puts "Available buffers: #{Dir.glob(File.join($pry_bufs, "*")).map {|f| File.basename(f) }.sort.join(", ")}"

    else
      buffer = args.empty? ? "default" : args[0]
      buffer_path = File.join($pry_bufs, buffer)

      if opts.d?
        if File.exists?(buffer_path)
          FileUtils.rm_f buffer_path
          FileUtils.touch buffer_path if buffer == "default"
          output.puts "Buffer #{buffer} cleaned"
        else
          output.puts "Buffer #{buffer} does not exists. No need to clean"
        end
      elsif opts.s?
        output.puts "Buffer #{buffer} contents:"
        output.puts stagger_output(colorize_code(File.read(buffer_path)))
      else
        FileUtils.touch buffer_path
        run "edit #{buffer_path} -r"
      end
    end
  end
end

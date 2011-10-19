# pry-buffers

Use buffers to edit and execute arbitrary code inside of pry. You can
think of this plugin as a vitamined version of the "edit -t" command
where the edited files are stored and can be reused.

# Installation

  gem install pry-buffers

# Usage

pry-buffers needs a HOME environment variable to be defined in order to
work properly.

    pry(main)> buf -h
    Usage: buf [-l|-s|-d|-h] <BUFFER>
    Open a text editor and evaluate its content upon close. When no buffer
    is given, the "default" buffer is used by default. You can also show or
    delete the contents of a given buffer or list all the stored buffers.
    e.g: buf
         buf test
         buf -d test
         buf -s test
         buf -l
         buf -h


    options:

        -s, --show        show the contents of the buffer
        -d, --delete      clears the given buffer
        -l, --list        List all the stored buffers
        -h, --help        This message

    pry(main)> buf

    pry(main)> buf -l
    Available buffers: default

    pry(main)> buf test
    This is a test

    pry(main)> buf -s test
    Buffer test contents:
    puts "This is a test"

    pry(main)> buf -l
    Available buffers: default, test

    pry(main)> buf -d test
    Buffer test cleaned

# Compatibility

pry-buffers been developed and tested against Ruby 1.9.2 and Pry 0.9.6.2.

# Contact

Please use GitHub (http://github.com/davidbarral/pry-buffers) to report bugs,
make suggestions or send patches.

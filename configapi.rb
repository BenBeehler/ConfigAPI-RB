module ConfigAPI
    class Config
        attr_accessor :lines
        attr_accessor :fpath

        def initialize file
            self.lines = []
            self.fpath = file

            file = File.new(fpath, 'r')
            
            self.lines = file.read.split "\n"

            file.close
        end

        def pull path 
            value = ""

            self.lines.each do |line|
                split = line.split ":"

                if path.strip == split[0].strip
                    value = line.sub! split[0] + ":", ""
                    break
                end
            end

            return value
        end

        def update path, value
            newlines = []

            self.lines.each do |line|
                split = line.split ":"


                if path.strip != split[0].strip 
                    newlines.push line
                end
            end

            newline = "#{path}:#{value}"

            newlines.push newline
            self.lines = newlines

            return self.lines
        end

        def save
            self.lines.each do |line|
                result = ""

                file = File.new fpath, 'a'

                if line.strip != "" then
                    file.puts "#{line}"
                end
            end
        end 

        def reload
            self.lines = []

            file = File.new(fpath, 'r')
            
            self.lines = file.read.split "\n"

            file.close
        end
    end
end

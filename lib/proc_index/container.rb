module ProcIndex
  class NoDataError < StandardError
  end

  class Container
    include Enumerable

    attr_accessor :body, :key

    def initialize(fields, data)
      @fields = fields
      @data   = data

      format_data!
    end

    def fields
      @fields
    end

  private
    def format_data!
      raise NoDataError.new('No data has been passed') unless @data

      # Clear out new line characters and split by lines
      @data = @data.strip.split(/[\r\n]+/)

      # The first line of the data object is the key
      self.key = @data[0].gsub(/%/, '').strip.squeeze(' ').downcase.split(' ')

      # Sub down the content with no spaces
      @data.each_with_index { |item, ndx| @data[ndx] = @data[ndx].strip.squeeze(' ') }

      # Assign all the values to their cooresponding keys from the fields
      temp_body  = []
      @data.each_with_index do |row, ndx|
        next if ndx == 0

        holder = {}
        row.split(' ', @fields.count).each_with_index do |value, ndx2|
          holder[self.key[ndx2]] = value
        end

        temp_body << Hashie::Mash.new(holder)
      end

      self.body = temp_body
    end
  end
end

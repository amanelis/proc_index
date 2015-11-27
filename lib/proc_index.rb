require 'proc_index/version'
require 'proc_index/container'

require 'open3'
require 'hashie'
require 'fuzzy_match'

module ProcIndex
  class Error < StandardError; end

  #
  # Base fields on OS X Process table -> `ps aux`
  @fields = [
    'user',
    'pid',
    'cpu',
    'mem',
    'vsz',
    'rss',
    'tt',
    'stat',
    'started',
    'time',
    'command'
  ]

  ProcTableStruct = Hash[ *@fields.collect { |v| [ v, {position: 0} ] }.flatten ]

  @states = [
    {code: 'R', desc: 'Running or runnable (on run queue)'},
    {code: 'D', desc: 'Uninterruptible sleep (usually IO)'},
    {code: 'S', desc: 'Interruptible sleep (waiting for an event to complete)'},
    {code: 'Z', desc: 'Defunct/zombie, terminated but not reaped by its parent'},
    {code: 'T', desc: 'Stopped, either by a job control signal or because it is being traced'}
  ]

  at_exit do
    puts 'Exiting' if $!
  end

  #
  # self.ps
  #
  def self.ps(pid=nil)
    array  = block_given? ? nil : []
    struct = nil

    raise TypeError unless pid.is_a?(Fixnum) if pid

    pid.nil? ? get_process_list : get_process_list(pid: pid)
  end

  #
  # self.search
  #   -> (pid: 10238492, command: 'spring isofun rails')
  #   -> (pid: 382973, user: 'alexmanelis')
  #   -> ('spring rails server')
  #
  def self.search(args)
    raise ArgumentError.new("Invalid arguments passed: #{args.inspect}") if args.nil?

    process_list = get_process_list
    process_body = process_list.body

    matcher_instances = []
    case args.class.to_s
      when 'Hash'
        args.map do |k, v|
          matcher_instances << {instance: FuzzyMatch.new(process_body, read: k), query: v}
        end
      when 'String'
        matcher_instances << {instance: FuzzyMatch.new(process_body, read: :command),
          query: args.strip.downcase}
      else
        raise ArgumentError.new("Invalid search args: #{args.inspect} -> #{args.class.inspect}")
    end

    results = matcher_instances.inject([]) do |result, instance|
      result << instance[:instance].find(instance[:query])
    end
  end

private

  #
  # self.get_process_list
  #
  def self.get_process_list
    yield if block_given?

    begin
      stdin, stdout, stderr = Open3.popen3("ps aux")

      stdout = stdout.read
      stderr = stderr.read
    rescue => e
      raise StandardError.new("Error opening stream from process list -> #{e}")
    end

    ProcIndex::Container.new(@fields, stdout)
  end

end

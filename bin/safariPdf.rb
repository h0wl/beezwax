base = __FILE__
while File.symlink?(base)
        base = File.expand_path(File.readlink(base), File.dirname(base))
end

$:.unshift(File.join(File.dirname(base), '../lib'))
  
require 'beezwax'

honeypot = Beezwax::Honeypot.new

subject = Beezwax::FileSubject.new
subject.readFile(ARGV[0])
honeypot.subject = subject

manipulator = Beezwax::PdfManipulator.new
manipulator.processSubject(subject)
honeypot.manipulator = manipulator

honeypot.executor = Beezwax::ProcessExecutor.new('/Applications/Safari.app/Contents/MacOS/Safari')
#honeypot.monitor = Beezwax::CrashlogDirectoryMonitor.new("/Users/#{ENV['USER']}/Library/Logs/CrashReporter", "../crashes/safari")
honeypot.monitor = Beezwax::ProcessMonitor.new
#honeypot.monitor = Beezwax::CrashlogDirectoryMonitor.new("/Users/#{ENV['USER']}/Library/Application Support/Google/Chrome/Crash Reports", "../crashes/chrome")
honeypot.fuzz
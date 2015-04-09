#!/usr/local/bin/ruby
# Make almost all filelist in my computer
#
# Features
# * Exclude unused files
# * List directory first
#
# Usage:
# * Print all files in computer
#     ruby make-filelist.rb > all.filelist
# * Print specified directories
#     ruby make-filelist.rb dir1 dir2 ... > partial.filelist
# * Use with cron: add this entry to crontab to make filelist at 1:00 AM.
#     0 1 * * * ruby /path/to/make-filelist.rb > /tmp/all.filelist
#
# Customize:
# You can override customize variables by creating ~/.make-filelist.rb

#
# ==== Customize Variables ====
# Exclude pathnames (version control system directories and so on)
$EXCLUDE_PATH = %w[
. ..  lost+found tmp temp
autom4te.cache blib _build .bzr .cdv cover_db CVS _darcs ~.dep ~.dot .git .hg ~.nib .pc ~.plst RCS SCCS _sgbak .svn1
]

# Exclude regexps (backup files, core files, and so on)
$EXCLUDE_REGEXP = Regexp.union(
  /~$/, /\#.+\#$/, /[._].*\.swp$/, /core\.\d+$/,
  # from ack-grep
  /\.(?:elc|o)$/, /,v$/
)

# Set default directories to collect
$LS_DIRS = [
  "~/Documents",
  "~/Downloads"
]
#$LS_DIRS = ["."]
# ==== End of Customize Variables =====

begin load "C:/.make-filelist.rb"; rescue LoadError; end # Load configuration file
$done = []                                              # Already collected directory
def ls(dir)
  if $done.include? dir or not File.readable? dir
    $stderr.puts "skipped #{dir}" if $VERBOSE
    return
  end
  dirs = []
  home_re = /^#{Regexp.quote(ENV['HOME'])}/ if ENV['HOME']
  Dir.foreach(dir) do |f|
    begin
      next if $EXCLUDE_PATH.include? f
      next if $EXCLUDE_REGEXP.match f
      f = File.join dir, f
      stat = File.lstat f
      abbrev = f.sub(home_re, '~') if ENV['HOME']
      if stat.directory? and not stat.symlink?
        puts "#{abbrev}/"
        dirs << f
      else
        puts abbrev
      end
    rescue
      $stderr.puts "#{dir}/#{f}: #$!"
    end
  end
  dirs.each do |d|
    ls d
  end
end

def ls_first(dir)
  edir = File.expand_path dir
  $stderr.puts "ls_first #{edir}" if $VERBOSE
  ls edir
  $done << edir
end

(ARGV.empty? ? $LS_DIRS : ARGV).each {|d| ls_first d }

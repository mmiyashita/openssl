#!/usr/local/bin/perl

# mkdir-p.pl

# On some systems, the -p option to mkdir (= also create any missing parent
# directories) is not available.

my $arg;

foreach $arg (@ARGV) {
  &do_mkdir_p($arg);
}


sub do_mkdir_p {
  local($dir) = @_;

  $dir =~ s|/*$||;

  if (-d $dir) {
    return;
  }

  if ($dir =~ /\//) {
    local($parent) = $dir;
    $parent =~ s|[^/]*$||;

    do_mkdir_p($parent);
  }

  mkdir($dir, 0777) || die "Cannot create directory $dir: $!\n";
  print "created directory $dir\n";
}

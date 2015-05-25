#!/usr/bin/perl

use strict;

open (F, "thesis.out");
open (OUT, ">/tmp/thesis.out");

while (<F>) {
    print OUT "\\let\\WriteBookmarks\\relax\n";
    print OUT $_;
    if ($_ =~ /Bibliographic Notes/) {
	print OUT "\\BOOKMARK [0][-]{chapter*.3}{Contents}{}";
    }
}

system("mv /tmp/thesis.out .");

#!/usr/bin/perl

my $latexfile = "thesis";
my $file = "/tmp/missing-refs.txt";

my @dirs = (qw(/home/feamster/bgp /home/feamster/bgpte /home/feamster/cvs/peerScope));
my $dirstring = join(" ", @dirs);

my %refs = ();


sub generate_missing_refs {

    system("latex $latexfile | grep -i \"warning: citation\" | sort | cut -f 4 -d ' ' | uniq -c > $file");


}

sub find_refs {

    open (F, "$file");

    while (<F>) {
	my ($foo, $count, $ref) = split(/\s+/);
	$ref =~ s/\`//g;
	$ref =~ s/\'//g;
	
	open (B, "find $dirstring -name '*.bib' |xargs grep -i $ref |");
	while (<B>) {
	    my ($file, $foo) = split(/:/);
	    print "find $ref in $file\n";
	    push(@{$refs{$file}}, $ref);
	    last;
	}
	close(B);
    }
}

sub print_refs {
    foreach my $bibfile (keys %refs) {
	print "\n\n****************************************\n$bibfile:\n";
	printf ("%s", join("\t\n", sort @{$refs{$bibfile}}));
    }
    printf "\n\n";
}



&generate_missing_refs();
&find_refs();
&print_refs();

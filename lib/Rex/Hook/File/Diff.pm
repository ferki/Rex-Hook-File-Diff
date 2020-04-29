package Rex::Hook::File::Diff;

# ABSTRACT: show diff of changes for files managed by Rex

use 5.012;
use strict;
use warnings;

our $VERSION = '9999';

use Rex 0.044 -base;
use Rex::Hook;
use Text::Diff 1.44;

register_function_hooks { before_change => { file => \&show_diff, }, };

sub show_diff {
    my ( $original_file, @opts ) = @_;

    if ( !Rex::is_local() ) {
        Rex::Logger::debug('Skipping File::Diff hook due to remote connection');
        return;
    }

    my $diff = diff( involved_files($original_file) );

    if ( length $diff > 0 ) { print "Diff for: $original_file\n$diff" }

    return;
}

sub involved_files {
    my $file = shift;

    my $temp_file = get_rex_temp_file_path($file);
    my $null      = File::Spec->devnull();

    if ( !is_file($file) )      { $file      = $null }    # creating file
    if ( !is_file($temp_file) ) { $temp_file = $null }    # removing file

    return ( $file, $temp_file );
}

sub get_rex_temp_file_path {
    my $file = shift;

    ## no critic ( CodeLayout RegularExpressions ValuesAndExpressions )
    # copied verbatim from Rex::Commands::File

    my @splitted_file = split( /[\/\\]/, $file );
    my $file_name     = ".rex.tmp." . pop(@splitted_file);
    my $tmp_file_name = (
        $#splitted_file != -1
        ? ( join( "/", @splitted_file ) . "/" . $file_name )
        : $file_name
    );

    ## use critic

    return $tmp_file_name;
}

1;

__END__

=for :stopwords CPAN

=head1 SYNOPSIS

    use Rex::Hook::File::Diff;

=head1 DESCRIPTION

This module allows L<Rex> to show a diff of changes for the files managed via its built-in L<file|https://metacpan.org/pod/Rex::Commands::File#file> command.

=head1 DIAGNOSTICS

This module does not do any error checking (yet).

=head1 CONFIGURATION AND ENVIRONMENT

This module does not require any configuration, nor does it use any environment variables.

=head1 DEPENDENCIES

See L<cpanfile>.

=head1 INCOMPATIBILITIES

There are no known incompatibilities with other modules.

=head1 BUGS AND LIMITATIONS

There are no known bugs. Make sure they are reported.

Currently the module supports local file operations only.

=cut

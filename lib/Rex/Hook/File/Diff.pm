package Rex::Hook::File::Diff;

# ABSTRACT: show diff of changes for files managed by Rex

use 5.012;
use warnings;

use File::Basename;
use IPC::Run;
use Rex 1.013004 -base;
use Rex::Helper::Run;
use Rex::Hook;
use Text::Diff 1.44;

our $VERSION = '9999';

register_function_hooks { before_change => { file => \&show_diff, }, };

sub show_diff {
    my ( $original_file, @opts ) = @_;

    my $diff;
    my $diff_command = can_run('diff');
    state $managing_windows = is_windows();

    if ( !$managing_windows && $diff_command ) {
        my $command = join q( ), $diff_command, '-u', involved_files($original_file);

        if ( $diff = i_run $command, fail_ok => TRUE ) {
            $diff .= "\n";
        }
    }
    elsif ( Rex::is_local() ) {
        $diff = diff( involved_files($original_file) );
    }
    else {
        Rex::Logger::debug(
            'Skipping File::Diff hook due to remote operation without the diff utility');
        return;
    }

    if ( length $diff > 0 ) {
        my @highlighter = qw( delta --color-only --diff-so-fancy );
        my $highlighted;

        IPC::Run::run \@highlighter, \$diff, \$highlighted;

        $diff = $highlighted;

        Rex::Commands::say("Diff for: $original_file\n$diff");
    }

    return;
}

sub involved_files {
    my $file = shift;

    my $temp_file = Rex::Commands::File::get_tmp_file_name($file);
    my $null      = File::Spec->devnull();

    if ( !is_file($file) )      { $file      = $null } # creating file
    if ( !is_file($temp_file) ) { $temp_file = $null } # removing file

    return ( $file, $temp_file );
}

1;

__END__

=for :stopwords backend CPAN sed

=head1 SYNOPSIS

    use Rex::Hook::File::Diff;

=head1 DESCRIPTION

This module allows L<Rex> to show a diff of changes for the files managed via its built-in L<file manipulation commands|https://metacpan.org/pod/Rex::Commands::File> which rely on the L<file|https://metacpan.org/pod/Rex::Commands::File#file> command as a backend:

=over 4

=item L<file|https://metacpan.org/pod/Rex::Commands::File#file>

=item L<delete_lines_matching|https://metacpan.org/pod/Rex::Commands::File#delete_lines_matching>

=item L<delete_lines_according_to|https://metacpan.org/pod/Rex::Commands::File#delete_lines_according_to>

=item L<append_if_no_such_line|https://metacpan.org/pod/Rex::Commands::File#append_if_no_such_line>

=item L<append_or_amend_line|https://metacpan.org/pod/Rex::Commands::File#append_or_amend_line>

=item L<sed|https://metacpan.org/pod/Rex::Commands::File#sed>

=back

It prefers to use the C<diff> utility on non-Windows managed endpoints, if available.

=head1 DIAGNOSTICS

This module does not do any error checking (yet).

=head1 CONFIGURATION AND ENVIRONMENT

This module does not require any configuration, nor does it use any environment variables.

=head1 DEPENDENCIES

See the included C<cpanfile>.

Requires the C<diff> utility to show the diff for remote file operations.

=head1 INCOMPATIBILITIES

There are no known incompatibilities with other modules.

=head1 BUGS AND LIMITATIONS

There are no known bugs. Make sure they are reported.

Upload hook support is not implemented (yet), so diff is not shown upon file uploads when using the C<source> option with the L<file|https://metacpan.org/pod/Rex::Commands::File#file> command (or the L<upload|https://metacpan.org/pod/Rex::Commands::Upload#upload> command directly).

=cut

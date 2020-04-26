# This file is generated by Dist::Zilla::Plugin::CPANFile v6.014
# Do not edit this file directly. To change prereqs, edit the `dist.ini` file.

requires "Rex" => "0.044";
requires "Rex::Hook" => "0";
requires "Text::Diff" => "1.44";
requires "perl" => "5.012";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "File::Basename" => "0";
  requires "File::Temp" => "0";
  requires "File::Touch" => "0.08";
  requires "Rex::Commands::File" => "0";
  requires "Test2::V0" => "0.000071";
  requires "Test::Output" => "0.03";
  requires "re" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Perl::Critic::Freenode" => "0.032";
  requires "Test::More" => "0";
  requires "Test::Perl::Critic" => "0";
  requires "Test::PerlTidy" => "0";
  requires "Test::Pod" => "1.41";
};

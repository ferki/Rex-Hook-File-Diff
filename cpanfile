# This file is generated by Dist::Zilla::Plugin::CPANFile v6.024
# Do not edit this file directly. To change prereqs, edit the `dist.ini` file.

requires "File::Basename" => "0";
requires "Rex" => "1.013004";
requires "Rex::Helper::Run" => "0";
requires "Rex::Hook" => "0";
requires "Text::Diff" => "1.44";
requires "perl" => "5.014";
requires "warnings" => "0";

on 'test' => sub {
  requires "English" => "0";
  requires "File::Temp" => "0";
  requires "File::Touch" => "0.08";
  requires "Rex::Commands::File" => "1.012";
  requires "Test2::V0" => "0.000071";
  requires "Test::File" => "1.443";
  requires "Test::Output" => "0.03";
  requires "perl" => "5.014";
  requires "re" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "File::Find" => "0";
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Perl::Critic::Community" => "1.000";
  requires "Perl::Critic::TooMuchCode" => "0.13";
  requires "Test::Kwalitee" => "1.21";
  requires "Test::More" => "0.88";
  requires "Test::Perl::Critic" => "0";
  requires "Test::PerlTidy" => "0";
  requires "Test::Pod" => "1.41";
  requires "strict" => "0";
};

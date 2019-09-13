# Demeter installation from source

- Target sofwater: [Demeter](https://github.com/bruceravel/demeter)
- Last tested: 2019-07-04
- Working on:
    - XUbuntu 18.04

It mainly follows [David Hughes' guide to Demeter Installation on Ubuntu](https://bruceravel.github.io/demeter/documents/SinglePage/demeter_nonroot.html).

## As root

Basic requirements of your system:

```bash
sudo apt install build-essential git gfortran gnuplot ifeffit liblocal-lib-perl libx11-dev libncurses5-dev libpng-dev libgif-dev libwxgtk3.0-dev libwx-perl libmodule-build-perl
```

## As user

It should be as simple as doing the followin steps in a BASH shell:

```bash
cd
echo 'eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' >> ~/.bashrc
source ~/.bashrc
cpan
cpan[1]> o conf build_requires_install_policy yes
cpan[2]> o conf prerequisites_policy follow
cpan[3]> o conf http_proxy http://proxy.esrf.fr:3128
cpan[4]> o conf ftp_proxy http://proxy.esrf.fr:3128
cpan[5]> o conf commit
mkdir local
cd local
git clone git://github.com/bruceravel/demeter.git
cd demeter
perl -I . ./Build.PL
./Build installdeps
perl -I . ./Build.PL
./Build
./Build test
./Build install
```

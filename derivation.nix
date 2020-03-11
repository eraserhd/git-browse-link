{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "git-browse-link";
  version = "0.1.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin/
    cp git-browse-link $out/bin/
  '';

  meta = with stdenv.lib; {
    description = "Retrieve a browse link for a file and location in a repo";
    homepage = https://github.com/eraserhd/git-browse-link;
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}

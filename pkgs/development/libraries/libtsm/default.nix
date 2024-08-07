{ lib, stdenv, fetchFromGitHub, libxkbcommon, pkg-config, cmake }:

stdenv.mkDerivation rec {
  pname = "libtsm";
  version = "develop";

  src = fetchFromGitHub {
    owner = "Aetf";
    repo = "libtsm";
    rev = version;
    sha256 = "sha256-Rug3OWSbbiIivItULPNNptClIZ/PrXdQeUypAAxrUY8=";
  };

  buildInputs = [ libxkbcommon ];

  nativeBuildInputs = [ cmake pkg-config ];

  meta = with lib; {
    description = "Terminal-emulator State Machine";
    homepage = "https://www.freedesktop.org/wiki/Software/kmscon/libtsm/";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

{ lib
, stdenv
, fetchFromGitHub
, meson
, libtsm
, systemd
, libxkbcommon
, libdrm
, libGLU
, libGL
, pango
, pixman
, pkg-config
, docbook_xsl
, libxslt
, mesa
, ninja
, buildPackages
, check
}:

stdenv.mkDerivation rec {
  pname = "kmscon";
  version = "Login-Session-Tracking";

  src = fetchFromGitHub {
    owner = "michael-oberpriller";
    repo = "kmscon";
    rev = version;
    sha256 = "sha256-/C9zEab+PYYKKBgAB/5QikD55Ab0frp8n++smgm8lCA=";
  };

  strictDeps = true;

  depsBuildBuild = [
    buildPackages.stdenv.cc
  ];

  buildInputs = [
    libGLU
    libGL
    libdrm
    libtsm
    libxkbcommon
    pango
    pixman
    systemd
    mesa
    check
  ];

  nativeBuildInputs = [
    meson
    ninja
    docbook_xsl
    pkg-config
    libxslt # xsltproc
  ];

  PKG_CONFIG_SYSTEMD_SYSTEMDSYSTEMUNITDIR = "${placeholder "out"}/lib/systemd/system";

  configureFlags = [
    "--enable-multi-seat"
    "--disable-debug"
    "--enable-optimizations"
    "--with-renderers=bbulk,gltex,pixman"
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "KMS/DRM based System Console";
    mainProgram = "kmscon";
    homepage = "https://www.freedesktop.org/wiki/Software/kmscon/";
    license = licenses.mit;
    maintainers = with maintainers; [ omasanori ];
    platforms = platforms.linux;
  };
}

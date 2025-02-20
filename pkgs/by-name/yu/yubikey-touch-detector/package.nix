{
  lib,
  libnotify,
  gpgme,
  buildGoModule,
  fetchFromGitHub,
  pkg-config,
}:

buildGoModule rec {
  pname = "yubikey-touch-detector";
  version = "1.12.0";

  src = fetchFromGitHub {
    owner = "maximbaz";
    repo = "yubikey-touch-detector";
    rev = version;
    hash = "sha256-Uh6DzDMBnTkKP1GW71TwGOfe3apDNNDUzZ5GLkPxrkE=";
  };
  vendorHash = "sha256-mhmYTicj/ihGNzeCZd1ZijWPkvxQZjBxaC5dyAU1O7U=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    libnotify
    gpgme
  ];

  postInstall = ''
    install -Dm444 -t $out/share/doc/${pname} *.{md,example}

    install -Dm444 -t $out/share/licenses/${pname} LICENSE

    install -Dm444 -t $out/share/icons/hicolor/128x128/apps yubikey-touch-detector.png

    install -Dm444 -t $out/lib/systemd/user *.{service,socket}

    substituteInPlace $out/lib/systemd/user/*.service \
      --replace /usr/bin/yubikey-touch-detector "$out/bin/yubikey-touch-detector"
  '';

  meta = with lib; {
    description = "Tool to detect when your YubiKey is waiting for a touch";
    homepage = "https://github.com/maximbaz/yubikey-touch-detector";
    maintainers = with maintainers; [ sumnerevans ];
    license = licenses.isc;
    platforms = platforms.linux;
    mainProgram = "yubikey-touch-detector";
  };
}

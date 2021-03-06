{ pkgs, ... }:
let
  requireCurl = { url, sha256 }: pkgs.lib.overrideDerivation
    (pkgs.requireFile { inherit url sha256; })
    (attrs: {
       builder = pkgs.writeScript "get-the-thing" ''
        #!${pkgs.stdenv.shell}
        '${pkgs.curl}/bin/curl' --cacert '${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt' --url '${url}' -o "$out"
       '';
     });
  clang = requireCurl {
    url = http://releases.llvm.org/4.0.0/clang+llvm-4.0.0-x86_64-linux-gnu-ubuntu-16.10.tar.xz;
    sha256 = "0j0kc73xvm2dl84f7gd2kh6a8nxlr7alk91846m0im77mvm631rv";
  };
  gcc = requireCurl {
    url = https://launchpadlibrarian.net/251687888/gcc-arm-none-eabi-5_3-2016q1-20160330-linux.tar.bz2;
    sha256 = "08x2sv2mhx3l3adw8kgcvmrs10qav99al410wpl18w19yfq50y11";
  };
in pkgs.runCommand "bolos-env" {} ''
  mkdir -p "$out"
  mkdir "$out/clang-arm-fropi"
  tar xavf '${clang}' --strip-components=1 -C "$out/clang-arm-fropi"
  mkdir "$out/gcc-arm-none-eabi-5_3-2016q1"
  tar xavf '${gcc}' --strip-components=1 -C "$out/gcc-arm-none-eabi-5_3-2016q1"
''

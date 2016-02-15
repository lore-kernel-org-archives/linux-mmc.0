From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH RESEND 0/3] arm64: salvator-x: enable SD card slots
Date: Mon, 15 Feb 2016 16:01:47 +0100
Message-ID: <1455548510-1690-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

These are the remaining patches needed to get the SD slots on a Salvator-X
board working. I decided to collect and resend them as a separate series to
make it more clear where we are and to ensure everyone is in the loop :)

There are no changes to patch 1 since it was originally posted. This one should
go via MMC. Patches 2+3 have never been posted but were available in my branch
and people tested them. Dirk, maybe you can add your Tested-by again? Those
patches should go via renesas-soc.

Would be great to have this in 4.6.

Thanks,

   Wolfram


Ai Kyuse (2):
  arm64: dts: r8a7795: Add SDHI support to dtsi
  arm64: dts: r8a7795: salvator-x: enable SDHI0 & 3

Wolfram Sang (1):
  mmc: sdhi: Add r8a7795 support

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 83 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 38 ++++++++++
 drivers/mmc/host/Kconfig                           |  2 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 47 ++++++++----
 5 files changed, 157 insertions(+), 14 deletions(-)

-- 
2.1.4

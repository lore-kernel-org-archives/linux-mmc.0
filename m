From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/4] R-Car D3 (r8a77995) SDHI (eMMC) integration
Date: Wed, 15 Nov 2017 16:25:45 +0100
Message-ID: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-mmc@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi!

This integrates the SDHI hardware on R-Car D3 and enables the Draak board's
eMMC drive. Includes whitelisting the internal DMAC on D3.

CU
Uli


Ulrich Hecht (4):
  mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
  arm64: dts: r8a77995: Add SDHI (MMC) support
  arm64: dts: r8a77995: draak: enable SDHI2
  dt-bindings: mmc: renesas_sdhi: Add r8a77995 support

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 44 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 12 ++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  2 +
 4 files changed, 59 insertions(+)

-- 
2.7.4

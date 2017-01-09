From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 0/6] arm64: allwinner: a64: Enable MMC support
Date: Mon,  9 Jan 2017 17:46:49 +0100
Message-ID: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

Here is a second attempt at getting the MMC controllers running, the first
having been done by Andre.

This has been tested on a board with one SDIO device (a Marvell WiFi chip)
and a Kingston eMMC with 1.8V IOs.

For SDIO, the HS DDR mode works just fine. There's a little bit of work to
get to SDR104, but that will come eventually.

For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
moment, but since it's significantly more complex, and at the same time
Allwinner recommends to limit its frequency to 100MHz, this doesn't have
any benefits. If there's any at some point, this can be added later.

Let me know what you think,
Maxime

Andre Przywara (1):
  arm64: allwinner: a64: Add MMC nodes

Maxime Ripard (5):
  mmc: sunxi: Always set signal delay to 0 for A64
  mmc: sunxi: Enable the new timings for the A64 MMC controllers
  mmc: sunxi: Add EMMC (MMC2) controller compatible
  arm64: allwinner: a64: Add MMC pinctrl nodes
  arm64: allwinner: a64: Increase the MMC max frequency

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 ++++++++++++++++++++-
 drivers/mmc/host/sunxi-mmc.c                  | 63 +++++++++----------
 2 files changed, 97 insertions(+), 33 deletions(-)

base-commit: f9ca9b952ee139fbb9cd4d354a33f440bc1049cd
-- 
git-series 0.8.11
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

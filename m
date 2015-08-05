From: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v4 0/6] mmc: imx: a few fixes and new feature
Date: Wed, 5 Aug 2015 18:38:36 +0800
Message-ID: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, johan.derycke-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Changes for v4:
-Call esdhc_set_strobe_dll() only when device clock is over 100MHz in HS400 mode.
-Add detail description of tuning-step.
-Change to default watermark level and burst length for all imx SoC, not only imx7d.

Haibo Chen (6):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step seting support
  mmc: sdhci-esdhc-imx: add compatible string in bingding doc
  ARM: dts: imx7d-sdb: add eMMC5.0 support
  mmc: sdhci-esdhc-imx: change default watermark level and burst length
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 109 ++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 4 files changed, 128 insertions(+), 1 deletion(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

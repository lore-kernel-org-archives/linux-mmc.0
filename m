From: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v6 0/6] mmc: imx: a few fixes and new feature
Date: Tue, 11 Aug 2015 19:38:25 +0800
Message-ID: <1439293111-21077-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: johan.derycke-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Changes for v6:
-remove duplicate code in esdhc_set_uhs_signaling().
-fix a typo for patch-2.
-make commit log of patch-3 more specific.

Haibo Chen (6):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step setting support
  mmc: sdhci-esdhc-imx: add imx7d support in bingding doc
  ARM: dts: imx7d-sdb: add eMMC5.0 support
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
  mmc: sdhci-esdhc-imx: change default watermark level and burst length

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 114 ++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 4 files changed, 130 insertions(+), 4 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

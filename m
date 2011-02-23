From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection and card detection
Date: Wed, 23 Feb 2011 14:51:53 +0100
Message-ID: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35662 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1BWNwA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2011 08:52:00 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>

Take #3, changes:

* also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
* remove unconditional BROKEN_CARD_DETECTION (leftover)
* improved kernel-doc about unused GPIO
* added tags from Eric

Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
chance to retest on mx51? What about the FSL guys? :)

Regards,

   Wolfram

Wolfram Sang (5):
  mmc: sdhci-esdhc-imx: add support for write protect on custom GPIO
  mmc: sdhci-esdhc: broken card detection is not a default quirk
  mmc: sdhci-esdhc-imx: add card detect on custom GPIO
  arm: mach-mx3: pcm043: add write-protect and card-detect for SD1
  arm: mach-mx3: use IMX_GPIO_NR instead of hard-coded values

 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |    4 +-
 arch/arm/mach-mx3/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c              |   19 +++-
 arch/arm/plat-mxc/include/mach/esdhc.h       |   12 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c           |  128 +++++++++++++++++++++++--
 drivers/mmc/host/sdhci-esdhc.h               |    1 -
 drivers/mmc/host/sdhci-of-esdhc.c            |    3 +-
 7 files changed, 148 insertions(+), 21 deletions(-)

-- 
1.7.2.3


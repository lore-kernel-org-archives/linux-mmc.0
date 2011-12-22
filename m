From: <r66093@freescale.com>
Subject: [PATCH 4/5 v2] ESDHC: Workaround for data crc error on p1010rdb
Date: Thu, 22 Dec 2011 18:22:00 +0800
Message-ID: <1324549321-30796-4-git-send-email-r66093@freescale.com>
References: <1324549321-30796-1-git-send-email-r66093@freescale.com>
 <1324549321-30796-2-git-send-email-r66093@freescale.com>
 <1324549321-30796-3-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:39935
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755225Ab1LVLKC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2011 06:10:02 -0500
In-Reply-To: <1324549321-30796-3-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

SD card read was failing (data crc error)on some cards at
maximum possible frequency on P1010(CCB frequency set to 400MHz).
Some clock deviations are also observed at this frequency.
Hence reduced the mmc clock freq.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- change the property to compatible for quirks

 drivers/mmc/host/sdhci-esdhc.h |    9 ++++++++-
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 include/linux/mmc/sdhci.h      |    2 ++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c3b08f1..060c3c4 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver generics for OF and pltfm.
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007,2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  * Copyright (c) 2010 Pengutronix e.K.
  *   Author: Wolfram Sang <w.sang@pengutronix.de>
@@ -56,6 +56,13 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		goto out;
 
+	if (host->quirks2 & SDHCI_QUIRK2_RELAX_FREQ) {
+		if (clock > 20000000)
+			clock -= 5000000;
+		if (clock > 40000000)
+			clock -= 5000000;
+	}
+
 	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
 		pre_div *= 2;
 
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 6791a2a..44aeebb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -83,6 +83,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 			|| of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+		if (of_device_is_compatible(np, "fsl,p1010-esdhc"))
+			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
+
 #ifdef CONFIG_PM
 		if (of_device_is_compatible(np, "fsl,p1022-esdhc")
 			sdhc_pmsaveproctlreg = 1;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e4b6935..f7c1e13 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -91,6 +91,8 @@ struct sdhci_host {
 	unsigned int quirks2;	/* More deviations from spec. */
 
 #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
+/* Controller operates the cards at reduced frequency */
+#define SDHCI_QUIRK2_RELAX_FREQ				(1<<1)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.5.4



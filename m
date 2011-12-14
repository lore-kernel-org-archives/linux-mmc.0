From: <r66093@freescale.com>
Subject: [PATCH 5/6] ESDHC: Workaround for data crc error on p1010rdb
Date: Wed, 14 Dec 2011 10:19:41 +0800
Message-ID: <1323829182-1551-6-git-send-email-r66093@freescale.com>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <1323829182-1551-3-git-send-email-r66093@freescale.com>
 <1323829182-1551-4-git-send-email-r66093@freescale.com>
 <1323829182-1551-5-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:38878 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab1LNDFw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 22:05:52 -0500
Received: from mail137-tx2 (localhost [127.0.0.1])	by
 mail137-tx2-R.bigfish.com (Postfix) with ESMTP id EA3F380209	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:53 +0000 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.244])	by
 mail137-tx2.bigfish.com (Postfix) with ESMTP id 86D3E1C0049	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:53 +0000 (UTC)
In-Reply-To: <1323829182-1551-5-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

SD card read was failing (data crc error)on some cards at
maximum possible frequency on P1010(CCB frequency set to 400MHz).
Some clock deviations are also observed at this frequency.
Hence reduced the mmc clock freq.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h |    9 ++++++++-
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 include/linux/mmc/sdhci.h      |    2 ++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 7cbaffe..e0d3029 100644
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
@@ -57,6 +57,13 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
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
index e39bb13..8ece860 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -83,6 +83,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 		if (of_get_property(np, "sdhci,ahb2mag-irq-bypass", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS;
+
+		if (of_get_property(np, "sdhci,relax-freq", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
 #ifdef CONFIG_PM
 		if (of_get_property(np, "pmsaveproctlreg", NULL))
 			sdhc_pmsaveproctlreg = 1;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1dbe22b..b5f9559 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -93,6 +93,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
 /* Controller cannot set DCR[DMA__AHB2MAG_IRQ_BYPASS] automatically */
 #define SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS		(1<<1)
+/* Controller operates the cards at reduced frequency */
+#define SDHCI_QUIRK2_RELAX_FREQ				(1<<2)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.5.4



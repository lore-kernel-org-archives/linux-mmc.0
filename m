From: <Chang-Ming.Huang@freescale.com>
Subject: [PATCH 1/3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Tue, 11 Sep 2012 15:12:43 +0800
Message-ID: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:48603 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320Ab2IKHpw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 03:45:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

CMD23 causes lots of errors in kernel on some freescale SoCs
when mmc card used, which is because these controllers does
not support CMD23, but even on SoCs which declare CMD23 is supported,
so we'll not use CMD23.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 drivers/mmc/host/sdhci.c       |    3 +++
 include/linux/mmc/sdhci.h      |    1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index d9a4ef4..1e532dd 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -83,6 +83,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+		if (of_get_property(np, "sdhci,no-cmd23", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d98b199..a7ec2a0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2829,6 +2829,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
+	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
+		mmc->caps &= ~MMC_CAP_CMD23;
+
 	if (caps[0] & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index fa8529a..1edcb4d 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -91,6 +91,7 @@ struct sdhci_host {
 	unsigned int quirks2;	/* More deviations from spec. */
 
 #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
+#define SDHCI_QUIRK2_HOST_NO_CMD23			(1<<1)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.9.5



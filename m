From: Haijun Zhang <haijun.zhang@freescale.com>
Subject: [PATCH] mmc:host eSDHC: mmc:host host need long time to generate command complete interrupt
Date: Sun, 7 Apr 2013 15:53:04 +0800
Message-ID: <1365321184-30895-1-git-send-email-haijun.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:31336
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161596Ab3DGI2p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Apr 2013 04:28:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <haijun.zhang@freescale.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

According to Spec 2.0, command complete interrupt will generate within
150 SD-CLK. But this was not enough on T4240 board. So give it sufficient
time to detect command timeout. 1000 * HZ will be enough, this value was
test on all T4 board, all worked well.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    7 ++++++-
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 drivers/mmc/host/sdhci.c       |   10 +++++++++-
 include/linux/mmc/sdhci.h      |    2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index cd0f1f6..ebdea9f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -92,6 +92,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
+		if (of_device_is_compatible(np, "fsl,t4240-esdhc"))
+			host->quirks2 |= SDHCI_QUIRK2_LONG_CMD_COMPLETE_IRQ;
+
 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
 		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
@@ -150,8 +153,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		host->ops = pdata->ops;
 	else
 		host->ops = &sdhci_pltfm_ops;
-	if (pdata)
+	if (pdata) {
 		host->quirks = pdata->quirks;
+		host->quirks2 = pdata->quirks2;
+	}
 	host->irq = platform_get_irq(pdev, 0);
 
 	if (!request_mem_region(iomem->start, resource_size(iomem),
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 1210ed1..83d42c6 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -18,6 +18,7 @@
 struct sdhci_pltfm_data {
 	const struct sdhci_ops *ops;
 	unsigned int quirks;
+	unsigned int quirks2;
 };
 
 struct sdhci_pltfm_host {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ea429c..9d34f09 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -974,6 +974,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	int flags;
 	u32 mask;
 	unsigned long timeout;
+	u32 timer = 10;
 
 	WARN_ON(host->cmd);
 
@@ -1002,7 +1003,14 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	mod_timer(&host->timer, jiffies + 10 * HZ);
+	/*
+	 * In case some controller need long time to generate command
+	 * interrupt, 1000 * HZ will be enough.
+	 */
+	if (host->quirks2 & SDHCI_QUIRK2_LONG_CMD_COMPLETE_IRQ)
+		timer = 1000;
+
+	mod_timer(&host->timer, jiffies + timer * HZ);
 
 	host->cmd = cmd;
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index b838ffc..f57037a 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -95,6 +95,8 @@ struct sdhci_host {
 /* The system physically doesn't support 1.8v, even if the host does */
 #define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
 #define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		(1<<3)
+/* Controller need long time to generate command complete interrupt */
+#define SDHCI_QUIRK2_LONG_CMD_COMPLETE_IRQ		(1<<4)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.0.4



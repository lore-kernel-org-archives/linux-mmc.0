From: <r66093@freescale.com>
Subject: [PATCH v6] ESDHC: Workaround for data crc error on p1010rdb
Date: Wed, 8 Feb 2012 11:30:48 +0800
Message-ID: <1328671848-15659-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:26997
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753228Ab2BHDdF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2012 22:33:05 -0500
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
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for v2:
        - change the property to compatible for quirks
changes for v3:
        - fix one compile error
changes for v4:
        - use hooks to suspend/resume the special platform
changes for v5:
        - add the Acked-by
changes for v6:
	- move the workaround codes to special platform from header file

 drivers/mmc/host/sdhci-of-esdhc.c |   18 +++++++++++++++++-
 drivers/mmc/host/sdhci-pltfm.c    |    3 +++
 include/linux/mmc/sdhci.h         |    3 +++
 3 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 2ef52f4..a79e6e8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -114,6 +114,22 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 	return pltfm_host->clock / 256 / 16;
 }
 
+static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	if (clock == 0) {
+		host->clock = clock;
+		return;
+	}
+
+	if (host->quirks2 & SDHCI_QUIRK2_RELAX_FREQ) {
+		if (clock > 20000000)
+			clock -= 5000000;
+		if (clock > 40000000)
+			clock -= 5000000;
+	}
+	esdhc_set_clock(host, clock);
+}
+
 #ifdef CONFIG_PM
 static u32 esdhc_proctl;
 static void esdhc_of_suspend(struct sdhci_host *host)
@@ -135,7 +151,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.write_l = sdhci_be32bs_writel,
 	.write_w = esdhc_writew,
 	.write_b = esdhc_writeb,
-	.set_clock = esdhc_set_clock,
+	.set_clock = esdhc_of_set_clock,
 	.enable_dma = esdhc_of_enable_dma,
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c5c2a48..0705838 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -79,6 +79,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+		if (of_device_is_compatible(np, "fsl,p1010-esdhc"))
+			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index c750f85..2418c91 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -90,6 +90,9 @@ struct sdhci_host {
 
 	unsigned int quirks2;	/* More deviations from spec. */
 
+/* Controller operates the cards at reduced frequency */
+#define SDHCI_QUIRK2_RELAX_FREQ				(1<<0)
+
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
-- 
1.7.5.4



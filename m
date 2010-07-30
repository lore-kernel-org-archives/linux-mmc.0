From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits workaround
Date: Fri, 30 Jul 2010 11:52:57 +0800
Message-ID: <1280461977-2023-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:6801 "EHLO
	VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750784Ab0G3EHe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jul 2010 00:07:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

P4080 ESDHC controller does not support 1.8V and 3.0V voltage. but the
host controller capabilities register wrongly set the bits.
This patch adds the workaround to correct the weird voltage setting bits.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
This is the second version of patch 
http://patchwork.ozlabs.org/patch/60106/
According to the comment, remove some un-necessary setting.

Together with patch
http://patchwork.ozlabs.org/patch/60111/
http://patchwork.ozlabs.org/patch/60116/

This serial patches add mmc support for p4080 silicon

 drivers/mmc/host/sdhci-of-core.c |    4 ++++
 drivers/mmc/host/sdhci.c         |    8 ++++++++
 drivers/mmc/host/sdhci.h         |    4 ++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index 0c30242..1f3913d 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -164,6 +164,10 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	if (sdhci_of_wp_inverted(np))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+	if (of_device_is_compatible(np, "fsl,p4080-esdhc"))
+		host->quirks |= (SDHCI_QUIRK_QORIQ_NO_VDD_180
+				|SDHCI_QUIRK_QORIQ_NO_VDD_300);
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1424d08..a667790 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1699,6 +1699,14 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
 
+	 /* Workaround for P4080 host controller capabilities
+	  * 1.8V and 3.0V do not supported*/
+	if (host->quirks & SDHCI_QUIRK_QORIQ_NO_VDD_180)
+		caps &= ~SDHCI_CAN_VDD_180;
+
+	if (host->quirks & SDHCI_QUIRK_QORIQ_NO_VDD_300)
+		caps &= ~SDHCI_CAN_VDD_300;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps & SDHCI_CAN_DO_SDMA))
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index aa112aa..389b58c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -243,6 +243,10 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
 /* Controller uses Auto CMD12 command to stop the transfer */
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
+/* Controller cannot support 1.8V */
+#define SDHCI_QUIRK_QORIQ_NO_VDD_180			(1<<28)
+/* Controller cannot support 3.0V */
+#define SDHCI_QUIRK_QORIQ_NO_VDD_300			(1<<29)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5



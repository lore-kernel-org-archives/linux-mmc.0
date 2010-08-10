From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 1/2] mmc: change ACMD12 to AUTO_CMD12 for more clear
Date: Tue, 10 Aug 2010 17:47:11 +0800
Message-ID: <1281433632-18758-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:8208 "EHLO
	VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab0HJKDn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 06:03:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, mirqus@gmail.com, cbouatmailru@gmail.com, grant.likely@secretlab.ca

Change ACMD12 to AUTO_CMD12 to reduce the confusion.
ACMD12 might be confused with MMC/SD App CMD 12 (CMD55+CMD12 combo).

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mmc/host/sdhci-of-core.c |    2 +-
 drivers/mmc/host/sdhci.c         |    8 ++++----
 drivers/mmc/host/sdhci.h         |   10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index dd1bdd1..d059805 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -155,7 +155,7 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	}
 
 	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
-		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12;
 
 
 	if (of_get_property(np, "sdhci,1-bit-only", NULL))
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a92566e..4b7b2d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -73,7 +73,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 		sdhci_readl(host, SDHCI_INT_ENABLE),
 		sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
 	printk(KERN_DEBUG DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
-		sdhci_readw(host, SDHCI_ACMD12_ERR),
+		sdhci_readw(host, SDHCI_AUTO_CMD12_ERR),
 		sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
 	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Max curr: 0x%08x\n",
 		sdhci_readl(host, SDHCI_CAPABILITIES),
@@ -818,8 +818,8 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	mode = SDHCI_TRNS_BLK_CNT_EN;
 	if (data->blocks > 1) {
-		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
-			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
+		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12)
+			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_AUTO_CMD12;
 		else
 			mode |= SDHCI_TRNS_MULTI;
 	}
@@ -1112,7 +1112,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 #ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_activate_led(host);
 #endif
-	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12) {
+	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12) {
 		if (mrq->stop) {
 			mrq->data->stop = NULL;
 			mrq->stop = NULL;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 8fb088c..dfe1c4a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -32,7 +32,7 @@
 #define SDHCI_TRANSFER_MODE	0x0C
 #define  SDHCI_TRNS_DMA		0x01
 #define  SDHCI_TRNS_BLK_CNT_EN	0x02
-#define  SDHCI_TRNS_ACMD12	0x04
+#define  SDHCI_TRNS_AUTO_CMD12	0x04
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
@@ -116,7 +116,7 @@
 #define  SDHCI_INT_DATA_CRC	0x00200000
 #define  SDHCI_INT_DATA_END_BIT	0x00400000
 #define  SDHCI_INT_BUS_POWER	0x00800000
-#define  SDHCI_INT_ACMD12ERR	0x01000000
+#define  SDHCI_INT_AUTO_CMD12_ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
 
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
@@ -130,7 +130,7 @@
 		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
-#define SDHCI_ACMD12_ERR	0x3C
+#define SDHCI_AUTO_CMD12_ERR	0x3C
 
 /* 3E-3F reserved */
 
@@ -157,7 +157,7 @@
 
 /* 4C-4F reserved for more max current */
 
-#define SDHCI_SET_ACMD12_ERROR	0x50
+#define SDHCI_SET_AUTO_CMD12_ERROR	0x50
 #define SDHCI_SET_INT_ERROR	0x52
 
 #define SDHCI_ADMA_ERROR	0x54
@@ -241,7 +241,7 @@ struct sdhci_host {
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
 /* Controller uses Auto CMD12 command to stop the transfer */
-#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
+#define SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12		(1<<27)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5



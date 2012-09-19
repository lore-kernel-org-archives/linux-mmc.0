From: <Haijun.Zhang@freescale.com>
Subject: [PATCH V3] Powerpc eSDHC Recover from the ADMA error
Date: Wed, 19 Sep 2012 17:22:39 +0800
Message-ID: <1348046559-13215-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:4372 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755606Ab2ISJsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 05:48:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

From: Haijun Zhang <Haijun.Zhang@freescale.com>

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for v3:
        - Correct the if statement in function workground

changes for v2:
        - Invert the condition of the if statement in function workground

 drivers/mmc/host/sdhci-of-esdhc.c |   53 ++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c          |    2 +
 drivers/mmc/host/sdhci.h          |    5 +++-
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 1cba55a..7a4c410 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -21,6 +21,7 @@
 #include "sdhci-esdhc.h"
 
 #define VENDOR_V_22	0x12
+#define VENDOR_V_23    0x13
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
@@ -83,6 +84,18 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
 	return ret;
 }
 
+static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	/*
+	 * Enable IRQSTATEN[BGESEN] is just to set IRQSTAT[BGE]
+	 * when SYSCTL[RSTD]) is set for some special operations.
+	 * No any impact other operation.
+	 */
+	if (reg == SDHCI_INT_ENABLE)
+		val |= SDHCI_INT_BLK_GAP;
+	sdhci_be32bs_writel(host, val, reg);
+}
+
 static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
 {
 	if (reg == SDHCI_BLOCK_SIZE) {
@@ -138,6 +151,43 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 	return of_host->clock / 256 / 16;
 }
 
+/*
+ * For Abort or Suspend after Stop at Block Gap, ignore the ADMA
+ * error(IRQSTAT[ADMAE]) if both Transfer Complete(IRQSTAT[TC])
+ * and Block Gap Event(IRQSTAT[BGE]) are also set.
+ * For Continue, apply soft reset for data(SYSCTL[RSTD]);
+ * and re-issue the entire read
+ * transaction from beginning.
+ */
+static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
+{
+	u32 tmp;
+	bool applicable;
+	dma_addr_t dmastart;
+	dma_addr_t dmanow;
+
+	tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
+
+	applicable = (intmask & SDHCI_INT_DATA_END) &&
+			(intmask & SDHCI_INT_BLK_GAP) &&
+			(tmp == VENDOR_V_23);
+	if (!applicable)
+		return;
+
+	host->data->error = 0;
+	dmastart = sg_dma_address(host->data->sg);
+	dmanow = dmastart + host->data->bytes_xfered;
+	/*
+	 * Force update to the next DMA block boundary.
+	 */
+	dmanow = (dmanow &
+		~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+		SDHCI_DEFAULT_BOUNDARY_SIZE;
+	host->data->bytes_xfered = dmanow - dmastart;
+	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+}
+
 #ifdef CONFIG_PM
 static u32 esdhc_proctl;
 static void esdhc_of_suspend(struct sdhci_host *host)
@@ -164,7 +214,7 @@ struct sdhci_of_data sdhci_esdhc = {
 		.read_l = esdhc_readl,
 		.read_w = esdhc_readw,
 		.read_b = esdhc_readb,
-		.write_l = sdhci_be32bs_writel,
+		.write_l = esdhc_writel,
 		.write_w = esdhc_writew,
 		.write_b = esdhc_writeb,
 		.set_clock = esdhc_set_clock,
@@ -175,5 +225,6 @@ struct sdhci_of_data sdhci_esdhc = {
 		.platform_suspend = esdhc_of_suspend,
 		.platform_resume = esdhc_of_resume,
 #endif
+		.adma_workaround = esdhci_of_adma_workaround,
 	},
 };
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 684f1a4..3d9365a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2143,6 +2143,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		printk(KERN_ERR "%s: ADMA error\n", mmc_hostname(host->mmc));
 		sdhci_show_adma_error(host);
 		host->data->error = -EIO;
+		if (host->ops->adma_workaround)
+			host->ops->adma_workaround(host, intmask);
 	}
 
 	if (host->data->error)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 209f707..138d8fc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -120,6 +120,7 @@
 #define SDHCI_SIGNAL_ENABLE	0x38
 #define  SDHCI_INT_RESPONSE	0x00000001
 #define  SDHCI_INT_DATA_END	0x00000002
+#define  SDHCI_INT_BLK_GAP	0x00000004
 #define  SDHCI_INT_DMA_END	0x00000008
 #define  SDHCI_INT_SPACE_AVAIL	0x00000010
 #define  SDHCI_INT_DATA_AVAIL	0x00000020
@@ -146,7 +147,8 @@
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
 		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
-		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
+		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR | \
+		SDHCI_INT_BLK_GAP)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
 #define SDHCI_ACMD12_ERR	0x3C
@@ -275,6 +277,7 @@ struct sdhci_ops {
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
+	void	(*adma_workaround)(struct sdhci_host *host, u32 intmask);
 
 };
 
-- 
1.7.0.4



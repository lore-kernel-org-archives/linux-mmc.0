From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH V5] Powerpc eSDHC Recover from the ADMA error
Date: Tue, 4 Dec 2012 10:41:28 +0800
Message-ID: <1354588888-2751-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:52605
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab2LDDAr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Dec 2012 22:00:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

A-003500: False ADMA Error might be reported when ADMA is used for
multiple block read command with Stop at Block Gap. If PROCTL[SABGREQ]
is set when the particular block's data is received by the System side
logic before entire block(with CRC) data is received by the SD side
logic, and also if ADMA descriptor line is fetched at the same time,
then DMA engine might report false ADMA error. eSDHC might not be able
to Continue(PROCTL[CREQ]=1)after Stop at Block Gap.
This issue will impact the eSDHC IP VVN2.3.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v5:
	- Add comment, no other changes

changes for v4:
	- Correct inconsistent issue

changes for v3:
	- Correct the if statement in function workground

changes for v2:
	- Invert the condition of the if statement in function workground

 drivers/mmc/host/sdhci-of-esdhc.c |   51 ++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c          |    2 +
 drivers/mmc/host/sdhci.h          |    5 +++-
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index cfabc43..60de2ee 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -22,6 +22,7 @@
 #include "sdhci-esdhc.h"
 
 #define VENDOR_V_22	0x12
+#define VENDOR_V_23	0x13
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
@@ -85,6 +86,18 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
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
@@ -121,6 +134,41 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 	sdhci_be32bs_writeb(host, val, reg);
 }
 
+/*
+ * For Abort or Suspend after Stop at Block Gap, ignore the ADMA
+ * error(IRQSTAT[ADMAE]) if both Transfer Complete(IRQSTAT[TC])
+ * and Block Gap Event(IRQSTAT[BGE]) are also set.
+ * For Continue, apply soft reset for data(SYSCTL[RSTD]);
+ * and re-issue the entire read transaction from beginning.
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
+		(intmask & SDHCI_INT_BLK_GAP) &&
+		(tmp == VENDOR_V_23);
+	if (!applicable)
+		return;
+
+	host->data->error = 0;
+	dmastart = sg_dma_address(host->data->sg);
+	dmanow = dmastart + host->data->bytes_xfered;
+	/*
+	 * Force update to the next DMA block boundary.
+	 */
+	dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+		SDHCI_DEFAULT_BOUNDARY_SIZE;
+	host->data->bytes_xfered = dmanow - dmastart;
+	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+}
+
 static int esdhc_of_enable_dma(struct sdhci_host *host)
 {
 	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
@@ -186,7 +234,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
 	.read_b = esdhc_readb,
-	.write_l = sdhci_be32bs_writel,
+	.write_l = esdhc_writel,
 	.write_w = esdhc_writew,
 	.write_b = esdhc_writeb,
 	.set_clock = esdhc_of_set_clock,
@@ -198,6 +246,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_suspend = esdhc_of_suspend,
 	.platform_resume = esdhc_of_resume,
 #endif
+	.adma_workaround = esdhci_of_adma_workaround,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 63b84eb..72f56b0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2282,6 +2282,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
 		sdhci_show_adma_error(host);
 		host->data->error = -EIO;
+		if (host->ops->adma_workaround)
+			host->ops->adma_workaround(host, intmask);
 	}
 
 	if (host->data->error)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 71a4a7e..a6d69b7 100644
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
@@ -278,6 +280,7 @@ struct sdhci_ops {
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
+	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 };
 
-- 
1.7.0.4



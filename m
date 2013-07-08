From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/4] mmc: esdhc: workaround for dma err in the last system transaction
Date: Mon, 8 Jul 2013 10:12:23 +0800
Message-ID: <1373249545-23928-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:2971
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753357Ab3GHDCI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Jul 2013 23:02:08 -0400
In-Reply-To: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

A-004388: eSDHC DMA might not stop if error occurs on system transaction

eSDHC DMA(SDMA/ADMA) might not stop if an error occurs in the last system
transaction. It may continue initiating additional transactions until
software reset for data/all is issued during error recovery. There is not
any data corruption to the SD data. The IRQSTAT[DMAE] is set when the
erratum occurs.
The only conditions under which issues occur are the following:
1. SDMA - For SD Write , the error occurs in the last system transaction.
No issue for SD read
2. ADMA
a. Block count is enabled: For SD write, the error occurs in the last system
transaction. There is no issue for SD read when block count is enabled.
b. Block count is disabled: Block count is designated by the ADMA descriptor
table, and the error occurs in the last system transaction when ADMA is
executing last descriptor line of table.

eSDHC may initiate additional system transactions. There is no data integrity
issue for case 1 and 2a described below. For case 2b, system data might be
corrupted.

Workaround: Set eSDHC_SYSCTL[RSTD] when IRQSTAT[DMAE] is set. For cases 2a and
2b above, add an extra descriptor line with zero data next to the last
descriptor line.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 113 +++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 15039e2..b22cab0 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/host.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
+#include <asm/mpc85xx.h>
 
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
@@ -142,6 +143,26 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 	sdhci_be32bs_writeb(host, val, reg);
 }
 
+static void esdhc_reset(struct sdhci_host *host, u8 mask)
+{
+	u32 ier;
+	u32 uninitialized_var(isav);
+
+	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
+		isav = esdhc_readl(host, SDHCI_INT_ENABLE);
+
+	esdhc_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+	mdelay(100);
+
+	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
+		ier = esdhc_readl(host, SDHCI_INT_ENABLE);
+		ier &= ~SDHCI_INT_ALL_MASK;
+		ier |= isav;
+		esdhc_writel(host, ier, SDHCI_INT_ENABLE);
+		esdhc_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+	}
+}
+
 /*
  * For Abort or Suspend after Stop at Block Gap, ignore the ADMA
  * error(IRQSTAT[ADMAE]) if both Transfer Complete(IRQSTAT[TC])
@@ -162,19 +183,93 @@ static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 	applicable = (intmask & SDHCI_INT_DATA_END) &&
 		(intmask & SDHCI_INT_BLK_GAP) &&
 		(tmp == VENDOR_V_23);
-	if (!applicable)
+	if (applicable) {
+
+		esdhc_reset(host, SDHCI_RESET_DATA);
+		host->data->error = 0;
+		dmastart = sg_dma_address(host->data->sg);
+		dmanow = dmastart + host->data->bytes_xfered;
+		/*
+		 * Force update to the next DMA block boundary.
+		 */
+		dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+			SDHCI_DEFAULT_BOUNDARY_SIZE;
+		host->data->bytes_xfered = dmanow - dmastart;
+		sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+
 		return;
+	}
 
-	host->data->error = 0;
-	dmastart = sg_dma_address(host->data->sg);
-	dmanow = dmastart + host->data->bytes_xfered;
 	/*
-	 * Force update to the next DMA block boundary.
+	 * Check for A-004388: eSDHC DMA might not stop if error
+	 * occurs on system transaction
+	 * Impact list:
+	 * T4240-R1.0 B4860-R1.0 P1010-R1.0
 	 */
-	dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
-		SDHCI_DEFAULT_BOUNDARY_SIZE;
-	host->data->bytes_xfered = dmanow - dmastart;
-	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+	if (!((fsl_svr_is(SVR_T4240) && fsl_svr_rev_is(1, 0)) ||
+		(fsl_svr_is(SVR_B4860) && fsl_svr_rev_is(1, 0)) ||
+		(fsl_svr_is(SVR_P1010) && fsl_svr_rev_is(1, 0))))
+		return;
+
+
+	esdhc_reset(host, SDHCI_RESET_DATA);
+
+	if (host->flags & SDHCI_USE_ADMA) {
+		u32 mod, i, offset;
+		u8 *desc;
+		dma_addr_t addr;
+		struct scatterlist *sg;
+
+		mod = esdhc_readl(host, SDHCI_TRANSFER_MODE);
+		if (mod & SDHCI_TRNS_BLK_CNT_EN) {
+			/*
+			 * In case read transfer there is no data
+			 * was corrupted
+			 */
+			if (host->data->flags & MMC_DATA_READ)
+				host->data->error = 0;
+
+			return;
+		}
+
+
+		BUG_ON(!host->data);
+		desc = host->adma_desc;
+		for_each_sg(host->data->sg, sg, host->sg_count, i) {
+			addr = sg_dma_address(sg);
+			offset = (4 - (addr & 0x3)) & 0x3;
+			if (offset)
+				desc += 8;
+			desc += 8;
+		}
+
+		/*
+		 * Add an extra zero descriptor next to the
+		 * terminating descriptor.
+		 */
+		desc += 8;
+		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
+
+		if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
+			desc -= 8;
+			desc[0] |= 0x2; /* end */
+		} else {
+			__le32 *dataddr = (__le32 __force *)(desc + 4);
+			__le16 *cmdlen = (__le16 __force *)desc;
+
+			cmdlen[0] = cpu_to_le16(0x3);
+			cmdlen[1] = cpu_to_le16(0);
+
+			dataddr[0] = cpu_to_le32(0);
+		}
+
+	}
+
+	if ((host->flags & SDHCI_USE_SDMA) &&
+			(host->data->flags & MMC_DATA_READ))
+		host->data->error = 0;
+
+	return;
 }
 
 static int esdhc_of_enable_dma(struct sdhci_host *host)
-- 
1.8.0



From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 3/5] mmc: esdhc: workaround for dma err in the last system transaction
Date: Tue, 3 Sep 2013 15:33:15 +0800
Message-ID: <1378193597-29059-3-git-send-email-Haijun.Zhang@freescale.com>
References: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.30] ([216.32.180.30]:54551 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932300Ab3ICHiL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 03:38:11 -0400
In-Reply-To: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cbouatmailru@gmail.com, galak@kernel.crashing.org
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

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
	- Depend on patch [1/5]

 drivers/mmc/host/sdhci-of-esdhc.c | 101 ++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index e328252..c531d75 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -21,9 +21,13 @@
 #include <linux/mmc/host.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
+#include <asm/mpc85xx.h>
 
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
+
+static u32 svr;
+
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
@@ -156,25 +160,101 @@ static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 	dma_addr_t dmastart;
 	dma_addr_t dmanow;
 
-	tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+	tmp = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
 	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
 
 	applicable = (intmask & SDHCI_INT_DATA_END) &&
 		(intmask & SDHCI_INT_BLK_GAP) &&
 		(tmp == VENDOR_V_23);
-	if (!applicable)
+	if (applicable) {
+
+		sdhci_reset(host, SDHCI_RESET_DATA);
+		host->data->error = 0;
+		dmastart = sg_dma_address(host->data->sg);
+		dmanow = dmastart + host->data->bytes_xfered;
+
+		/* Force update to the next DMA block boundary. */
+		dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+			SDHCI_DEFAULT_BOUNDARY_SIZE;
+		host->data->bytes_xfered = dmanow - dmastart;
+		esdhc_writel(host, dmanow, SDHCI_DMA_ADDRESS);
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
+	 * T4240-4160-R1.0 B4860-4420-R1.0-R2.0 P1010-1014-R1.0
+	 * P3041-R1.0-R2.0-R1.1 P2041-2040-R1.0-R1.1-R2.0
+	 * P5020-5010-R2.0-R1.0 P5040-5021-R2.0-R2.1
 	 */
-	dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
-		SDHCI_DEFAULT_BOUNDARY_SIZE;
-	host->data->bytes_xfered = dmanow - dmastart;
-	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+	if (!(((SVR_SOC_VER(svr) == SVR_T4240) && (SVR_REV(svr) == 0x10)) ||
+		((SVR_SOC_VER(svr) == SVR_T4160) && (SVR_REV(svr) == 0x10)) ||
+		((SVR_SOC_VER(svr) == SVR_B4420) && (SVR_REV(svr) == 0x10)) ||
+		((SVR_SOC_VER(svr) == SVR_B4420) && (SVR_REV(svr) == 0x20)) ||
+		((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_REV(svr) == 0x10)) ||
+		((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_REV(svr) == 0x20)) ||
+		((SVR_SOC_VER(svr) == SVR_P1010) && (SVR_REV(svr) == 0x10)) ||
+		((SVR_SOC_VER(svr) == SVR_P1014) && (SVR_REV(svr) == 0x10)) ||
+		((SVR_SOC_VER(svr) == SVR_P3041) && (SVR_REV(svr) <= 0x20)) ||
+		((SVR_SOC_VER(svr) == SVR_P2041) && (SVR_REV(svr) <= 0x20)) ||
+		((SVR_SOC_VER(svr) == SVR_P2040) && (SVR_REV(svr) <= 0x20)) ||
+		((SVR_SOC_VER(svr) == SVR_P5020) && (SVR_REV(svr) <= 0x20)) ||
+		((SVR_SOC_VER(svr) == SVR_P5010) && (SVR_REV(svr) <= 0x20)) ||
+		((SVR_SOC_VER(svr) == SVR_P5021) && (SVR_REV(svr) <= 0x21)) ||
+		((SVR_SOC_VER(svr) == SVR_P5040) && (SVR_REV(svr) <= 0x21))))
+		return;
+
+	sdhci_reset(host, SDHCI_RESET_DATA);
+
+	if (host->flags & SDHCI_USE_ADMA) {
+		u32 mod, i, offset;
+		u8 *desc;
+		dma_addr_t addr;
+		struct scatterlist *sg;
+		__le32 *dataddr;
+		__le32 *cmdlen;
+
+		/*
+		 * If block count was enabled, in case read transfer there
+		 * is no data was corrupted
+		 */
+		mod = esdhc_readl(host, SDHCI_TRANSFER_MODE);
+		if ((mod & SDHCI_TRNS_BLK_CNT_EN) &&
+			(host->data->flags & MMC_DATA_READ))
+			host->data->error = 0;
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
+		dataddr = (__le32 __force *)(desc + 4);
+		cmdlen = (__le32 __force *)desc;
+
+		cmdlen[0] = cpu_to_le32(0);
+		dataddr[0] = cpu_to_le32(0);
+	}
+
+	if ((host->flags & SDHCI_USE_SDMA) &&
+		(host->data->flags & MMC_DATA_READ))
+		host->data->error = 0;
+
+	return;
 }
 
 static int esdhc_of_enable_dma(struct sdhci_host *host)
@@ -299,6 +379,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	struct device_node *np;
 	int ret;
 
+	svr = mfspr(SPRN_SVR);
 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-- 
1.8.0



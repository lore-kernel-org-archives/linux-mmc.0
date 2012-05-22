From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 2/4] mmc: dw_mmc: fix the IDMAC sw reset
Date: Tue, 22 May 2012 13:01:03 +0900
Message-ID: <006901cd37cf$81750420$845f0c60$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60731 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2EVEBI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 00:01:08 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4E00I5WOHPLFE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:01:03 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4E005WPOHR60G0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:01:03 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

IDMAC may not be cleaned in driver probe if it has
been already used in boot time. So IDMAC needs sw
reset newly. And DMA interface reset precedes the
internal DMAC reset. Additionally SDMMC_IDMAC_SWRESET
is replaced with magic code.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b46faf0..98fe023 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -418,6 +418,8 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	p->des3 = host->sg_dma;
 	p->des0 = IDMAC_DES0_ER;
 
+	mci_writel(host, BMOD, SDMMC_IDMAC_SWRESET);
+
 	/* Mask out interrupts - get Tx & Rx complete only */
 	mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI | SDMMC_IDMAC_INT_RI |
 		   SDMMC_IDMAC_INT_TI);
@@ -1724,7 +1726,8 @@ static void dw_mci_work_routine_card(struct work_struct *work)
 
 #ifdef CONFIG_MMC_DW_IDMAC
 				ctrl = mci_readl(host, BMOD);
-				ctrl |= 0x01; /* Software reset of DMA */
+				/* Software reset of DMA */
+				ctrl |= SDMMC_IDMAC_SWRESET;
 				mci_writel(host, BMOD, ctrl);
 #endif
 
@@ -1949,10 +1952,6 @@ int dw_mci_probe(struct dw_mci *host)
 	spin_lock_init(&host->lock);
 	INIT_LIST_HEAD(&host->queue);
 
-
-	host->dma_ops = host->pdata->dma_ops;
-	dw_mci_init_dma(host);
-
 	/*
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
@@ -1980,10 +1979,11 @@ int dw_mci_probe(struct dw_mci *host)
 	}
 
 	/* Reset all blocks */
-	if (!mci_wait_reset(&host->dev, host)) {
-		ret = -ENODEV;
-		goto err_dmaunmap;
-	}
+	if (!mci_wait_reset(&host->dev, host))
+		return -ENODEV;
+
+	host->dma_ops = host->pdata->dma_ops;
+	dw_mci_init_dma(host);
 
 	/* Clear the interrupts for the host controller */
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
@@ -2169,14 +2169,14 @@ int dw_mci_resume(struct dw_mci *host)
 	if (host->vmmc)
 		regulator_enable(host->vmmc);
 
-	if (host->dma_ops->init)
-		host->dma_ops->init(host);
-
 	if (!mci_wait_reset(&host->dev, host)) {
 		ret = -ENODEV;
 		return ret;
 	}
 
+	if (host->dma_ops->init)
+		host->dma_ops->init(host);
+
 	/* Restore the old value at FIFOTH register */
 	mci_writel(host, FIFOTH, host->fifoth_val);
 
-- 
1.7.0.4



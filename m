From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] Revert "mmc: dw_mmc: Add check for IDMAC configuration"
Date: Tue, 11 Sep 2012 11:23:37 +0900
Message-ID: <00d801cd8fc4$738f8540$5aae8fc0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54627 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757288Ab2IKCXj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Sep 2012 22:23:39 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MA50010SYNECKL0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 11 Sep 2012 11:23:38 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MA500DJAYNDQ600@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 11 Sep 2012 11:23:37 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, girish.shivananjappa@linaro.org, will.newton@imgtec.com, 'James Hogan' <James.Hogan@imgtec.com>

This reverts commit 94c6cee91(Add check for IDMAC configuration).
Synopsys says that only if internal dmac is not present, optional
external dma interface is present. When internal dmac is present,
'0' value in DMA_INTERFACE of HCON is reasonable. DMA_INTERFACE
indicates external dma interface. And idmac initialization is
prohibited now. So, let's revert this commit.

CC: Girish K S <girish.shivananjappa@linaro.org>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 36f98c0..dcbe9aa 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -405,23 +405,11 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 static int dw_mci_idmac_init(struct dw_mci *host)
 {
 	struct idmac_desc *p;
-	int i, dma_support;
+	int i;
 
 	/* Number of descriptors in the ring buffer */
 	host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
 
-	/* Check if Hardware Configuration Register has support for DMA */
-	dma_support = (mci_readl(host, HCON) >> 16) & 0x3;
-
-	if (!dma_support || dma_support > 2) {
-		dev_err(&host->dev,
-			"Host Controller does not support IDMA Tx.\n");
-		host->dma_ops = NULL;
-		return -ENODEV;
-	}
-
-	dev_info(&host->dev, "Using internal DMA controller.\n");
-
 	/* Forward link the descriptor list */
 	for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
 		p->des3 = host->sg_dma + (sizeof(struct idmac_desc) * (i + 1));
@@ -1895,6 +1883,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	/* Determine which DMA interface to use */
 #ifdef CONFIG_MMC_DW_IDMAC
 	host->dma_ops = &dw_mci_idmac_ops;
+	dev_info(&host->dev, "Using internal DMA controller.\n");
 #endif
 
 	if (!host->dma_ops)
-- 
1.7.0.4



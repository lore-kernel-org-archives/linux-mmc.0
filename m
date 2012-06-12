From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [RESEND PATCH] mmc: dw_mmc: Add check for IDMAC configuration
Date: Tue, 12 Jun 2012 15:28:22 +0530
Message-ID: <1339495102-4889-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58271 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab2FLJ6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 05:58:37 -0400
Received: by pbbrp8 with SMTP id rp8so580238pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jun 2012 02:58:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org, will.newton@imgtec.com, Girish K S <girish.shivananjappa@linaro.org>

In the Current dwmmc driver there is support for selecting IDMAC from
the menu config option. If the support for IDMAC is enabled in the menu
config and Hardware configuration register's DMA_INTERFACE field is 0.
Still the driver will try to do the DMA initialization.

The dw_mci_idmac_init function currently implemented returns only success
indicating that the DMA initialization is always successful. The current
patch will add a ciheck for existance of the DMA IP and allow the
DMA initialization.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cbd8f3d..c485d1b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -405,11 +405,23 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 static int dw_mci_idmac_init(struct dw_mci *host)
 {
 	struct idmac_desc *p;
-	int i;
+	int i, dma_support;
 
 	/* Number of descriptors in the ring buffer */
 	host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
 
+	/* Check if Hardware Configuration Register has support for DMA */
+	dma_support = (mci_readl(host, HCON) >> 16) & 0x3;
+
+	if (!dma_support || dma_support > 2) {
+		dev_err(&host->dev,
+			"Host Controller does not support IDMA Tx.\n");
+		host->dma_ops = NULL;
+		return -ENODEV;
+	}
+
+	dev_info(&host->dev, "Using internal DMA controller.\n");
+
 	/* Forward link the descriptor list */
 	for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
 		p->des3 = host->sg_dma + (sizeof(struct idmac_desc) * (i + 1));
@@ -1871,7 +1883,6 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	/* Determine which DMA interface to use */
 #ifdef CONFIG_MMC_DW_IDMAC
 	host->dma_ops = &dw_mci_idmac_ops;
-	dev_info(&host->dev, "Using internal DMA controller.\n");
 #endif
 
 	if (!host->dma_ops)
-- 
1.7.4.1


From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: dw_mmc: Add check for IDMAC configuration
Date: Tue, 12 Jun 2012 09:51:06 +0530
Message-ID: <1339474866-17805-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47164 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2FLEVV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 00:21:21 -0400
Received: by dady13 with SMTP id y13so6307468dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jun 2012 21:21:21 -0700 (PDT)
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
 drivers/mmc/host/dw_mmc.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cbd8f3d..9821293 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -405,7 +405,16 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 static int dw_mci_idmac_init(struct dw_mci *host)
 {
 	struct idmac_desc *p;
-	int i;
+	int i, dma_support;
+
+	/* Check if Hardware Configuration Register has support for DMA */
+	dma_support = (mci_readl(host, HCON) >> 16) & 0x3;
+
+	if (!dma_support || dma_support > 2) {
+		dev_err(&host->dev,
+			"Host Controller does not support DMA Tx.\n");
+		return -ENODEV;
+	}
 
 	/* Number of descriptors in the ring buffer */
 	host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
-- 
1.7.4.1


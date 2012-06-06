From: <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: fix burst/chunk size modification
Date: Wed, 6 Jun 2012 12:19:44 +0200
Message-ID: <1338977984-10888-1-git-send-email-ludovic.desroches@atmel.com>
References: <87396869fw.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:29751 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2FFKTv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jun 2012 06:19:51 -0400
In-Reply-To: <87396869fw.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, linux-mmc@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

The use of DMA slave config operation requires that the burst size
(aka chunk size) is specified through this interface.
Modify atmel-mci slave driver to use this specification on its side.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
Hi Chris,

Sorry for this trouble, this patch should apply well on 3.5-rc1.

Thanks

Regards

Ludovic


 drivers/mmc/host/atmel-mci-regs.h |   14 ++++++++++++++
 drivers/mmc/host/atmel-mci.c      |    8 +++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index 787aba1..ab56f7d 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -140,4 +140,18 @@
 #define atmci_writel(port,reg,value)			\
 	__raw_writel((value), (port)->regs + reg)
 
+/*
+ * Fix sconfig's burst size according to atmel MCI. We need to convert them as:
+ * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
+ *
+ * This can be done by finding most significant bit set.
+ */
+static inline unsigned int atmci_convert_chksize(unsigned int maxburst)
+{
+	if (maxburst > 1)
+		return fls(maxburst) - 2;
+	else
+		return 0;
+}
+
 #endif /* __DRIVERS_MMC_ATMEL_MCI_H__ */
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 420aca6..556d384 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -910,6 +910,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	enum dma_data_direction		direction;
 	enum dma_transfer_direction	slave_dirn;
 	unsigned int			sglen;
+	u32				maxburst;
 	u32 iflags;
 
 	data->error = -EINPROGRESS;
@@ -943,17 +944,18 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	if (!chan)
 		return -ENODEV;
 
-	if (host->caps.has_dma)
-		atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(3) | ATMCI_DMAEN);
-
 	if (data->flags & MMC_DATA_READ) {
 		direction = DMA_FROM_DEVICE;
 		host->dma_conf.direction = slave_dirn = DMA_DEV_TO_MEM;
+		maxburst = atmci_convert_chksize(host->dma_conf.src_maxburst);
 	} else {
 		direction = DMA_TO_DEVICE;
 		host->dma_conf.direction = slave_dirn = DMA_MEM_TO_DEV;
+		maxburst = atmci_convert_chksize(host->dma_conf.dst_maxburst);
 	}
 
+	atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(maxburst) | ATMCI_DMAEN);
+
 	sglen = dma_map_sg(chan->device->dev, data->sg,
 			data->sg_len, direction);
 
-- 
1.7.5.4


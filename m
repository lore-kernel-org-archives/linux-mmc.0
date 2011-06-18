From: Sebastian Rasmussen <sebras@gmail.com>
Subject: [PATCH] mmci: Fix checkpatch warnings
Date: Sat, 18 Jun 2011 19:45:30 +0200
Message-ID: <1308419130-18143-1-git-send-email-sebras@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:25044 "EHLO mail.df.lth.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab1FRRpi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 13:45:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sebastian Rasmussen <sebras@hotmail.com>

From: Sebastian Rasmussen <sebras@hotmail.com>

Pretty self-descriptive.

Signed-off-by: Sebastian Rasmussen <sebras@hotmail.com>
---
 drivers/mmc/host/mmci.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5da5bea..a94f965 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -29,9 +29,9 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/amba/mmci.h>
+#include <linux/io.h>
 
 #include <asm/div64.h>
-#include <asm/io.h>
 #include <asm/sizes.h>
 
 #include "mmci.h"
@@ -329,11 +329,10 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 			data->error = -EIO;
 	}
 
-	if (data->flags & MMC_DATA_WRITE) {
+	if (data->flags & MMC_DATA_WRITE)
 		dir = DMA_TO_DEVICE;
-	} else {
+	else
 		dir = DMA_FROM_DEVICE;
-	}
 
 	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
 
@@ -445,7 +444,8 @@ static inline void mmci_dma_data_error(struct mmci_host *host)
 {
 }
 
-static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+static inline int mmci_dma_start_data(struct mmci_host *host,
+		unsigned int datactrl)
 {
 	return -ENOSYS;
 }
@@ -557,7 +557,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
 	/* First check for errors */
-	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
+		      MCI_RXOVERRUN)) {
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
@@ -606,11 +607,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			/* The error clause is handled above, success! */
 			data->bytes_xfered = data->blksz * data->blocks;
 
-		if (!data->stop) {
+		if (!data->stop)
 			mmci_request_end(host, data->mrq);
-		} else {
+		else
 			mmci_start_command(host, data->stop, 0);
-		}
 	}
 }
 
@@ -642,7 +642,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 }
 
-static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int remain)
+static int mmci_pio_read(struct mmci_host *host, char *buffer,
+		unsigned int remain)
 {
 	void __iomem *base = host->base;
 	char *ptr = buffer;
@@ -673,7 +674,8 @@ static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int rema
 	return ptr - buffer;
 }
 
-static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int remain, u32 status)
+static int mmci_pio_write(struct mmci_host *host, char *buffer,
+		unsigned int remain, u32 status)
 {
 	struct variant_data *variant = host->variant;
 	void __iomem *base = host->base;
@@ -799,7 +801,8 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 */
 	if (host->size == 0) {
 		mmci_set_mask1(host, 0);
-		writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK, base + MMCIMASK0);
+		writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK,
+			base + MMCIMASK0);
 	}
 
 	return IRQ_HANDLED;
@@ -836,11 +839,13 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 
 		data = host->data;
 		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
-			      MCI_RXOVERRUN|MCI_DATAEND|MCI_DATABLOCKEND) && data)
+			      MCI_RXOVERRUN|MCI_DATAEND|MCI_DATABLOCKEND)
+			      && data)
 			mmci_data_irq(host, data, status);
 
 		cmd = host->cmd;
-		if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND) && cmd)
+		if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|
+			      MCI_CMDRESPEND) && cmd)
 			mmci_cmd_irq(host, cmd, status);
 
 		ret = 1;
@@ -907,7 +912,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (host->plat->vdd_handler)
 			pwr |= host->plat->vdd_handler(mmc_dev(mmc), ios->vdd,
 						       ios->power_mode);
-		/* The ST version does not have this, fall through to POWER_ON */
+		/* ST version does not have this, fall through to POWER_ON */
 		if (host->hw_designer != AMBA_VENDOR_ST) {
 			pwr |= MCI_PWR_UP;
 			break;
@@ -1164,7 +1169,8 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	    && host->gpio_cd_irq < 0)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
+	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED,
+			DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto unmap;
 
-- 
1.7.5.4


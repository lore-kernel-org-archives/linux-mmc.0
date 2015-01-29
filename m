From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: moxart: fix probe logic
Date: Thu, 29 Jan 2015 17:15:31 +0100
Message-ID: <8340872.32GezMfzR1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52496 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbA2QP7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 11:15:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jonas Jensen <jonas.jensen@gmail.com>, linux-arm-kernel@lists.infradead.org

Jonas Jensen wanted to submit a patch for these, but apparently
forgot about it. I stumbled over this symptom first:

drivers/built-in.o: In function `moxart_probe':
:(.text+0x2af128): undefined reference to `of_dma_request_slave_channel'

This is because of_dma_request_slave_channel is an internal helper
and not exported to loadable module. I'm changing the driver to
use dma_request_slave_channel_reason() instead.

Further problems from inspection:

* The remove function must not call kfree on the host pointer,
  because it is allocated together with the mmc_host.

* The clock is never released

* The dma_cap_mask_t is completely unused and can be removed

* deferred probing does not work if the dma driver is loaded
  after the mmc driver.

This patch should fix all of the above.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Jonas, can you check this patch and provide an Ack if it's ok?

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index d2a1ef61ec97..d9401a1cc589 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
 #include <linux/dma-mapping.h>
@@ -131,6 +132,7 @@ struct moxart_host {
 	struct mmc_host			*mmc;
 	struct mmc_request		*mrq;
 	struct scatterlist		*cur_sg;
+	struct clk			*clk;
 	struct completion		dma_complete;
 	struct completion		pio_complete;
 
@@ -560,9 +562,7 @@ static int moxart_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct moxart_host *host = NULL;
 	struct dma_slave_config cfg;
-	struct clk *clk;
 	void __iomem *reg_mmc;
-	dma_cap_mask_t mask;
 	int irq, ret;
 	u32 i;
 
@@ -586,10 +586,10 @@ static int moxart_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	clk = of_clk_get(node, 0);
-	if (IS_ERR(clk)) {
+	host->clk = of_clk_get(node, 0);
+	if (IS_ERR(host->clk)) {
 		dev_err(dev, "of_clk_get failed\n");
-		ret = PTR_ERR(clk);
+		ret = PTR_ERR(host->clk);
 		goto out;
 	}
 
@@ -603,18 +603,15 @@ static int moxart_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->base = reg_mmc;
 	host->reg_phys = res_mmc.start;
 	host->timeout = msecs_to_jiffies(1000);
-	host->sysclk = clk_get_rate(clk);
+	host->sysclk = clk_get_rate(host->clk);
 	host->fifo_width = readl(host->base + REG_FEATURE) << 2;
-	host->dma_chan_tx = of_dma_request_slave_channel(node, "tx");
-	host->dma_chan_rx = of_dma_request_slave_channel(node, "rx");
+	host->dma_chan_tx = dma_request_slave_channel_reason(dev, "tx");
+	host->dma_chan_rx = dma_request_slave_channel_reason(dev, "rx");
 
 	spin_lock_init(&host->lock);
 
@@ -624,6 +621,11 @@ static int moxart_probe(struct platform_device *pdev)
 	mmc->ocr_avail = 0xffff00;	/* Support 2.0v - 3.6v power. */
 
 	if (IS_ERR(host->dma_chan_tx) || IS_ERR(host->dma_chan_rx)) {
+		if (PTR_ERR(host->dma_chan_tx) == -EPROBE_DEFER ||
+		    PTR_ERR(host->dma_chan_rx) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
 		dev_dbg(dev, "PIO mode transfer enabled\n");
 		host->have_dma = false;
 	} else {
@@ -677,6 +679,8 @@ static int moxart_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	if (host->clk)
+		clk_put(host->clk);
 	if (mmc)
 		mmc_free_host(mmc);
 	return ret;
@@ -694,6 +698,7 @@ static int moxart_remove(struct platform_device *pdev)
 			dma_release_channel(host->dma_chan_tx);
 		if (!IS_ERR(host->dma_chan_rx))
 			dma_release_channel(host->dma_chan_rx);
+		clk_put(host->clk);
 		mmc_remove_host(mmc);
 		mmc_free_host(mmc);
 
@@ -702,9 +707,6 @@ static int moxart_remove(struct platform_device *pdev)
 		writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 		       host->base + REG_CLOCK_CONTROL);
 	}
-
-	kfree(host);
-
 	return 0;
 }
 


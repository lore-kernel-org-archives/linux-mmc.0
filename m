From: Jonas Jensen <jonas.jensen@gmail.com>
Subject: [PATCH v4] mmc: moxart: fix probe logic
Date: Tue,  3 Feb 2015 16:55:54 +0100
Message-ID: <1422978954-14547-1-git-send-email-jonas.jensen@gmail.com>
References: <6294882.EhDcdWGRYz@wuerfel>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:58232 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932393AbbBCP4J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Feb 2015 10:56:09 -0500
Received: by mail-la0-f41.google.com with SMTP id gm9so53166721lab.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Feb 2015 07:56:07 -0800 (PST)
In-Reply-To: <6294882.EhDcdWGRYz@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, ulf.hansson@linaro.org, linux@arm.linux.org.uk, Jonas Jensen <jonas.jensen@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

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
Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    This is a forward of Arnd's v2 patch.
    
    v2:  do not call clk_put() on an error pointer
    v3:  fix NULL dereference on host->clk
    v4:  rework to use devm_clk_get()
    
    Applies to next-20150113

 drivers/mmc/host/moxart-mmc.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index d2a1ef6..6cb4053 100644
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
@@ -562,7 +563,6 @@ static int moxart_probe(struct platform_device *pdev)
 	struct dma_slave_config cfg;
 	struct clk *clk;
 	void __iomem *reg_mmc;
-	dma_cap_mask_t mask;
 	int irq, ret;
 	u32 i;
 
@@ -586,9 +586,9 @@ static int moxart_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	clk = of_clk_get(node, 0);
+	clk = devm_clk_get(dev, 0);
 	if (IS_ERR(clk)) {
-		dev_err(dev, "of_clk_get failed\n");
+		dev_err(dev, "devm_clk_get failed\n");
 		ret = PTR_ERR(clk);
 		goto out;
 	}
@@ -603,9 +603,6 @@ static int moxart_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->base = reg_mmc;
@@ -613,8 +610,8 @@ static int moxart_probe(struct platform_device *pdev)
 	host->timeout = msecs_to_jiffies(1000);
 	host->sysclk = clk_get_rate(clk);
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
@@ -702,9 +704,6 @@ static int moxart_remove(struct platform_device *pdev)
 		writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 		       host->base + REG_CLOCK_CONTROL);
 	}
-
-	kfree(host);
-
 	return 0;
 }
 
-- 
1.8.2.1


From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] mmc: mvsdio: use dev_*() API instead of pr_*() API
Date: Wed, 20 Mar 2013 16:09:41 +0100
Message-ID: <1363792181-26512-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:48713 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352Ab3CTPJo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 11:09:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Ralph Droms <rdroms.ietf@gmail.com>

The mvsdio driver was already using some dev_*() functions to print
some messages, but still using pr_*() functions for some others. This
patch converts all messages to use dev_*() functions.

Many of the pr_*() function calls were printing the output of
mmc_hostname() to preprend the message with an identifier for the
device. Since the dev_*() functions do that automatically, this patch
also gets rid of those string prefixes.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
This is for 3.10.
---
 drivers/mmc/host/mvsdio.c |   37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 145cdaf..3cce2de 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -119,10 +119,8 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		host->pio_size = data->blocks * data->blksz;
 		host->pio_ptr = sg_virt(data->sg);
 		if (!nodma)
-			pr_debug("%s: fallback to PIO for data "
-					  "at 0x%p size %d\n",
-					  mmc_hostname(host->mmc),
-					  host->pio_ptr, host->pio_size);
+			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
+				host->pio_ptr, host->pio_size);
 		return 1;
 	} else {
 		dma_addr_t phys_addr;
@@ -473,8 +471,8 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		if (mrq->data)
 			err_status = mvsd_finish_data(host, mrq->data, err_status);
 		if (err_status) {
-			pr_err("%s: unhandled error status %#04x\n",
-					mmc_hostname(host->mmc), err_status);
+			dev_err(host->dev, "unhandled error status %#04x\n",
+				err_status);
 			cmd->error = -ENOMSG;
 		}
 
@@ -491,9 +489,8 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 	if (irq_handled)
 		return IRQ_HANDLED;
 
-	pr_err("%s: unhandled interrupt status=0x%04x en=0x%04x "
-			"pio=%d\n", mmc_hostname(host->mmc), intr_status,
-			host->intr_en, host->pio_size);
+	dev_err(host->dev, "%s: unhandled interrupt status=0x%04x en=0x%04x pio=%d\n",
+		intr_status, host->intr_en, host->pio_size);
 	return IRQ_NONE;
 }
 
@@ -507,13 +504,11 @@ static void mvsd_timeout_timer(unsigned long data)
 	spin_lock_irqsave(&host->lock, flags);
 	mrq = host->mrq;
 	if (mrq) {
-		pr_err("%s: Timeout waiting for hardware interrupt.\n",
-				mmc_hostname(host->mmc));
-		pr_err("%s: hw_state=0x%04x, intr_status=0x%04x "
-				"intr_en=0x%04x\n", mmc_hostname(host->mmc),
-				mvsd_read(MVSD_HW_STATE),
-				mvsd_read(MVSD_NOR_INTR_STATUS),
-				mvsd_read(MVSD_NOR_INTR_EN));
+		dev_err(host->dev, "Timeout waiting for hardware interrupt.\n");
+		dev_err(host->dev, "hw_state=0x%04x, intr_status=0x%04x intr_en=0x%04x\n",
+			mvsd_read(MVSD_HW_STATE),
+			mvsd_read(MVSD_NOR_INTR_STATUS),
+			mvsd_read(MVSD_NOR_INTR_EN));
 
 		host->mrq = NULL;
 
@@ -778,7 +773,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq, mvsd_irq, 0, DRIVER_NAME, host);
 	if (ret) {
-		pr_err("%s: cannot assign irq %d\n", DRIVER_NAME, irq);
+		dev_err(&pdev->dev, "cannot assign irq %d\n", irq);
 		goto out;
 	}
 
@@ -797,13 +792,11 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	pr_notice("%s: %s driver initialized, ",
-			   mmc_hostname(mmc), DRIVER_NAME);
 	if (!(mmc->caps & MMC_CAP_NEEDS_POLL))
-		printk("using GPIO %d for card detection\n",
-		       gpio_card_detect);
+		dev_notice(&pdev->dev, "using GPIO %d for card detection\n",
+			   gpio_card_detect);
 	else
-		printk("lacking card detect (fall back to polling)\n");
+		dev_notice(&pdev->dev, "lacking card detect (fall back to polling)\n");
 	return 0;
 
 out:
-- 
1.7.9.5


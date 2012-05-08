From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/3] mmc: omap: convert to per instance workqueue
Date: Tue, 8 May 2012 17:05:33 +0530
Message-ID: <1336476935-16564-2-git-send-email-svenkatr@ti.com>
References: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60162 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab2EHL34 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 May 2012 07:29:56 -0400
In-Reply-To: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Currently, a global mmc_omap_wq is created for all instances of
omap hosts, which can lead to races and doesn't lend itself to
unload the module cleanly.
Instead, create per instance workqueue and remove the common workqueue.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 887c0e5..2d7628e 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -169,11 +169,11 @@ struct mmc_omap_host {
 	struct timer_list       clk_timer;
 	spinlock_t		clk_lock;     /* for changing enabled state */
 	unsigned int            fclk_enabled:1;
+	struct workqueue_struct *mmc_omap_wq;
 
 	struct omap_mmc_platform_data *pdata;
 };
 
-static struct workqueue_struct *mmc_omap_wq;
 
 static void mmc_omap_fclk_offdelay(struct mmc_omap_slot *slot)
 {
@@ -291,7 +291,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
 		host->next_slot = new_slot;
 		host->mmc = new_slot->mmc;
 		spin_unlock_irqrestore(&host->slot_lock, flags);
-		queue_work(mmc_omap_wq, &host->slot_release_work);
+		queue_work(host->mmc_omap_wq, &host->slot_release_work);
 		return;
 	}
 
@@ -459,7 +459,7 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 	}
 
 	host->stop_data = data;
-	queue_work(mmc_omap_wq, &host->send_stop_work);
+	queue_work(host->mmc_omap_wq, &host->send_stop_work);
 }
 
 static void
@@ -639,7 +639,7 @@ mmc_omap_cmd_timer(unsigned long data)
 		OMAP_MMC_WRITE(host, IE, 0);
 		disable_irq(host->irq);
 		host->abort = 1;
-		queue_work(mmc_omap_wq, &host->cmd_abort_work);
+		queue_work(host->mmc_omap_wq, &host->cmd_abort_work);
 	}
 	spin_unlock_irqrestore(&host->slot_lock, flags);
 }
@@ -828,7 +828,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 		host->abort = 1;
 		OMAP_MMC_WRITE(host, IE, 0);
 		disable_irq_nosync(host->irq);
-		queue_work(mmc_omap_wq, &host->cmd_abort_work);
+		queue_work(host->mmc_omap_wq, &host->cmd_abort_work);
 		return IRQ_HANDLED;
 	}
 
@@ -1389,7 +1389,7 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 
 	tasklet_kill(&slot->cover_tasklet);
 	del_timer_sync(&slot->cover_timer);
-	flush_workqueue(mmc_omap_wq);
+	flush_workqueue(slot->host->mmc_omap_wq);
 
 	mmc_remove_host(mmc);
 	mmc_free_host(mmc);
@@ -1497,6 +1497,10 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 
 	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
 
+	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
+	if (!host->mmc_omap_wq)
+		goto err_plat_cleanup;
+
 	return 0;
 
 err_plat_cleanup:
@@ -1542,6 +1546,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
 	iounmap(host->virt_base);
 	release_mem_region(pdev->resource[0].start,
 			   pdev->resource[0].end - pdev->resource[0].start + 1);
+	destroy_workqueue(host->mmc_omap_wq);
 
 	kfree(host);
 
@@ -1610,22 +1615,12 @@ static struct platform_driver mmc_omap_driver = {
 
 static int __init mmc_omap_init(void)
 {
-	int ret;
-
-	mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
-	if (!mmc_omap_wq)
-		return -ENOMEM;
-
-	ret = platform_driver_probe(&mmc_omap_driver, mmc_omap_probe);
-	if (ret)
-		destroy_workqueue(mmc_omap_wq);
-	return ret;
+	return platform_driver_probe(&mmc_omap_driver, mmc_omap_probe);
 }
 
 static void __exit mmc_omap_exit(void)
 {
 	platform_driver_unregister(&mmc_omap_driver);
-	destroy_workqueue(mmc_omap_wq);
 }
 
 module_init(mmc_omap_init);
-- 
1.7.5.4


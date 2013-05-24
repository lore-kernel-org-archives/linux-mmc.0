From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 1/8] sdhci: Turn timeout timer into delayed work
Date: Fri, 24 May 2013 18:00:35 +0200
Message-ID: <1369411242-20515-2-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35666 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322Ab3EXQBc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 May 2013 12:01:32 -0400
In-Reply-To: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

There is no need for the timeout handler to run in the atomic
context, so this patch turns timeout timeout into the delayed
work.

Note that the timeout handler still grabs an irqsave spinlock,
we'll deal with it in a separate patch.

Patch based on http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c  |   13 +++++++------
 include/linux/mmc/sdhci.h |    3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ea429c..9d75338 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -13,6 +13,7 @@
  *     - JMicron (hardware and technical support)
  */
 
+#include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
@@ -1002,7 +1003,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	mod_timer(&host->timer, jiffies + 10 * HZ);
+	schedule_delayed_work(&host->timeout_work, 10 * HZ);
 
 	host->cmd = cmd;
 
@@ -2113,7 +2114,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 		return;
 	}
 
-	del_timer(&host->timer);
+	cancel_delayed_work(&host->timeout_work);
 
 	mrq = host->mrq;
 
@@ -2153,12 +2154,12 @@ static void sdhci_tasklet_finish(unsigned long param)
 	sdhci_runtime_pm_put(host);
 }
 
-static void sdhci_timeout_timer(unsigned long data)
+static void sdhci_timeout_work(struct work_struct *wk)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
 
-	host = (struct sdhci_host*)data;
+	host = container_of(wk, struct sdhci_host, timeout_work.work);
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -3163,7 +3164,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
 
-	setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
+	INIT_DELAYED_WORK(&host->timeout_work, sdhci_timeout_work);
 
 	if (host->version >= SDHCI_SPEC_300) {
 		init_waitqueue_head(&host->buf_ready_int);
@@ -3266,7 +3267,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	free_irq(host->irq, host);
 
-	del_timer_sync(&host->timer);
+	flush_delayed_work(&host->timeout_work);
 
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index b838ffc..0f14546 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -12,6 +12,7 @@
 #define LINUX_MMC_SDHCI_H
 
 #include <linux/scatterlist.h>
+#include <linux/workqueue.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/io.h>
@@ -159,7 +160,7 @@ struct sdhci_host {
 	struct tasklet_struct card_tasklet;	/* Tasklet structures */
 	struct tasklet_struct finish_tasklet;
 
-	struct timer_list timer;	/* Timer for timeouts */
+	struct delayed_work	timeout_work;	/* Work for timeouts */
 
 	u32 caps;		/* Alternative CAPABILITY_0 */
 	u32 caps1;		/* Alternative CAPABILITY_1 */
-- 
1.7.10.4


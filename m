From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is first
 claimed
Date: Mon, 12 Dec 2011 16:46:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112121642080.10378@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-mmc@vger.kernel.org

Some MMC hosts implement a fine-grained runtime PM, whereby they
runtime-suspend and -resume the host interface on each transfer. This can
negatively affect performance, if the user was trying to transfer data
blocks back-to-back. This patch adds a PM QoS constraint to avoid such a
throughput reduction. This constraint prevents runtime-suspending the
device, if the expected wakeup latency is larger than 100us.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch has been tested on SuperH and ARM sh-mobile hosts with 
sh_mobile_sdhi and sh_mmcif drivers. Would be good to also have it tested 
on other platforms, enabling PM QoS, e.g., those, using the simple QoS 
PM domain governor.

 drivers/mmc/core/core.c  |   16 +++++++++++++++-
 include/linux/mmc/host.h |    2 ++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b27b940..40f666f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 
@@ -589,8 +590,16 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 		wake_up(&host->wq);
 	spin_unlock_irqrestore(&host->lock, flags);
 	remove_wait_queue(&host->wq, &wait);
-	if (!stop)
+	if (!stop) {
+		if (host->claim_cnt == 1) {
+			int ret = dev_pm_qos_add_request(host->parent,
+							 &host->pm_qos, 100);
+			if (ret < 0)
+				dev_err(host->parent,
+					"PM QoS request failed: %d\n", ret);
+		}
 		mmc_host_enable(host);
+	}
 	return stop;
 }
 
@@ -615,6 +624,10 @@ int mmc_try_claim_host(struct mmc_host *host)
 		claimed_host = 1;
 	}
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (claimed_host && host->claim_cnt == 1)
+		dev_pm_qos_add_request(host->parent, &host->pm_qos, 100);
+
 	return claimed_host;
 }
 EXPORT_SYMBOL(mmc_try_claim_host);
@@ -639,6 +652,7 @@ void mmc_do_release_host(struct mmc_host *host)
 		host->claimer = NULL;
 		spin_unlock_irqrestore(&host->lock, flags);
 		wake_up(&host->wq);
+		dev_pm_qos_remove_request(&host->pm_qos);
 	}
 }
 EXPORT_SYMBOL(mmc_do_release_host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1d09562..3e9d2f3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -11,6 +11,7 @@
 #define LINUX_MMC_HOST_H
 
 #include <linux/leds.h>
+#include <linux/pm_qos.h>
 #include <linux/sched.h>
 
 #include <linux/mmc/core.h>
@@ -175,6 +176,7 @@ struct mmc_host {
 	u32			ocr_avail_sd;	/* SD-specific OCR */
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
 	struct notifier_block	pm_notify;
+	struct dev_pm_qos_request pm_qos;
 
 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
-- 
1.7.2.5


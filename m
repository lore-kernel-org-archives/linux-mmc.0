From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 01/38] mmc: sdio_irq: rework sdio irq handling
Date: Wed, 23 Apr 2014 20:06:15 +0100
Message-ID: <E1Wd2Up-0003uJ-7k@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46343 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932491AbaDWTGR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:06:17 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Rather than the SDIO support spawning it's own thread for handling card
interrupts, use the generic IRQ infrastructure for this, triggering it
from the host interface's interrupt handling directly.

This avoids a race between the parent thread waiting to receive an
interrupt response from the card, and the slow startup from the sdio
irq thread, which can occur as a result of high system load (eg, while
udev is running.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/sdio_irq.c | 41 +++++++++++++++++++++++++++++++----------
 include/linux/mmc/host.h    |  3 +++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index aaa90460ed23..f23d73993dc6 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -90,6 +90,15 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	return ret;
 }
 
+void sdio_run_irqs(struct mmc_host *host)
+{
+	mmc_claim_host(host);
+	host->sdio_irq_pending = true;
+	process_sdio_pending_irqs(host);
+	mmc_release_host(host);
+}
+EXPORT_SYMBOL_GPL(sdio_run_irqs);
+
 static int sdio_irq_thread(void *_host)
 {
 	struct mmc_host *host = _host;
@@ -189,14 +198,20 @@ static int sdio_card_irq_get(struct mmc_card *card)
 	WARN_ON(!host->claimed);
 
 	if (!host->sdio_irqs++) {
-		atomic_set(&host->sdio_irq_thread_abort, 0);
-		host->sdio_irq_thread =
-			kthread_run(sdio_irq_thread, host, "ksdioirqd/%s",
-				mmc_hostname(host));
-		if (IS_ERR(host->sdio_irq_thread)) {
-			int err = PTR_ERR(host->sdio_irq_thread);
-			host->sdio_irqs--;
-			return err;
+		if (!(host->caps2 & MMC_CAP2_SDIO_NOTHREAD)) {
+			atomic_set(&host->sdio_irq_thread_abort, 0);
+			host->sdio_irq_thread =
+				kthread_run(sdio_irq_thread, host,
+					    "ksdioirqd/%s", mmc_hostname(host));
+			if (IS_ERR(host->sdio_irq_thread)) {
+				int err = PTR_ERR(host->sdio_irq_thread);
+				host->sdio_irqs--;
+				return err;
+			}
+		} else {
+			mmc_host_clk_hold(host);
+			host->ops->enable_sdio_irq(host, 1);
+			mmc_host_clk_release(host);
 		}
 	}
 
@@ -211,8 +226,14 @@ static int sdio_card_irq_put(struct mmc_card *card)
 	BUG_ON(host->sdio_irqs < 1);
 
 	if (!--host->sdio_irqs) {
-		atomic_set(&host->sdio_irq_thread_abort, 1);
-		kthread_stop(host->sdio_irq_thread);
+		if (!(host->caps2 & MMC_CAP2_SDIO_NOTHREAD)) {
+			atomic_set(&host->sdio_irq_thread_abort, 1);
+			kthread_stop(host->sdio_irq_thread);
+		} else {
+			mmc_host_clk_hold(host);
+			host->ops->enable_sdio_irq(host, 0);
+			mmc_host_clk_release(host);
+		}
 	}
 
 	return 0;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cb61ea4d6945..28c5e796292f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -278,6 +278,7 @@ struct mmc_host {
 #define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \
 				 MMC_CAP2_PACKED_WR)
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
+#define MMC_CAP2_SDIO_NOTHREAD	(1 << 15)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
@@ -391,6 +392,8 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 	wake_up_process(host->sdio_irq_thread);
 }
 
+void sdio_run_irqs(struct mmc_host *host);
+
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
-- 
1.8.3.1


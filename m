From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] mmc: core: sdio: Fix unconditional wake_up_process() on sdio
 thread
Date: Mon, 11 Aug 2014 13:49:27 +0800
Message-ID: <53E85967.5060503@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, ulf.hansson@linaro.org, tgih.jun@samsung.com, aaron.lu@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jackey.shen@amd.com, gregkh@linuxfoundation.org
List-Id: linux-mmc@vger.kernel.org

>From 6cee984e1d76ba0a3320430f8cf4318ab65fcf06 Mon Sep 17 00:00:00 2001
From: Fu Zhonghui <zhonghui.fu@linux.intel.com>
Date: Tue, 5 Aug 2014 12:44:38 +0800
Subject: [PATCH] mmc: core: sdio: Fix unconditional wake_up_process() on sdio thread

781e989cf59 ("mmc: sdhci: convert to new SDIO IRQ handling") and
bf3b5ec66bd ("mmc: sdio_irq: rework sdio irq handling") disabled
the use of our own custom threaded IRQ handler, but left in an
unconditional wake_up_process() on that handler at resume-time.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=80151

In addition, the check for MMC_CAP_SDIO_IRQ capability is added
before enable sdio IRQ.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Chris Ball <chris@printf.net>
Signed-off-by: Fu Zhonghui <zhonghui.fu@linux.intel.com>
---
 drivers/mmc/core/sdio.c     |   14 ++++++++++++--
 drivers/mmc/core/sdio_irq.c |    4 ++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index e636d9e..e04a540 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -992,8 +992,18 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 	}
 
-	if (!err && host->sdio_irqs)
-		wake_up_process(host->sdio_irq_thread);
+	if (!err && host->sdio_irqs) {
+		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
+			wake_up_process(host->sdio_irq_thread);
+		} else if (host->caps & MMC_CAP_SDIO_IRQ) {
+			mmc_release_host(host);
+			mmc_host_clk_hold(host);
+			host->ops->enable_sdio_irq(host, 1);
+			mmc_host_clk_release(host);
+			mmc_claim_host(host);
+		}
+	}
+
 	mmc_release_host(host);
 
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 5cc13c8..696eca4 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -208,7 +208,7 @@ static int sdio_card_irq_get(struct mmc_card *card)
 				host->sdio_irqs--;
 				return err;
 			}
-		} else {
+		} else if (host->caps & MMC_CAP_SDIO_IRQ) {
 			mmc_host_clk_hold(host);
 			host->ops->enable_sdio_irq(host, 1);
 			mmc_host_clk_release(host);
@@ -229,7 +229,7 @@ static int sdio_card_irq_put(struct mmc_card *card)
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD)) {
 			atomic_set(&host->sdio_irq_thread_abort, 1);
 			kthread_stop(host->sdio_irq_thread);
-		} else {
+		} else if (host->caps & MMC_CAP_SDIO_IRQ) {
 			mmc_host_clk_hold(host);
 			host->ops->enable_sdio_irq(host, 0);
 			mmc_host_clk_release(host);
-- 1.7.1

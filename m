From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
Date: Sun,  8 Sep 2019 12:12:30 +0200
Message-ID: <20190908101236.2802-6-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The sdio_irq_pending flag is used to let host drivers indicate that it has
signaled an IRQ. If that is the case and we only have a single SDIO func
that have claimed an SDIO IRQ, our assumption is that we can avoid reading
the SDIO_CCCR_INTx register and just call the SDIO func irq handler
immediately. This makes sense, but the flag is set/cleared in a somewhat
messy order, let's fix that up according to below.

First, the flag is currently set in sdio_run_irqs(), which is executed as a
work that was scheduled from sdio_signal_irq(). To make it more implicit
that the host have signaled an IRQ, let's instead immediately set the flag
in sdio_signal_irq(). This also makes the behavior consistent with host
drivers that uses the legacy, mmc_signal_sdio_irq() API. This have no
functional impact, because we don't expect host drivers to call
sdio_signal_irq() until after the work (sdio_run_irqs()) have been executed
anyways.

Second, currently we never clears the flag when using the sdio_run_irqs()
work, but only when using the sdio_irq_thread(). Let make the behavior
consistent, by moving the flag to be cleared inside the common
process_sdio_pending_irqs() function. Additionally, tweak the behavior of
the flag slightly, by avoiding to clear it unless we processed the SDIO
IRQ. The purpose with this at this point, is to keep the information about
whether there have been an SDIO IRQ signaled by the host, so at system
resume we can decide to process it without reading the SDIO_CCCR_INTx
register.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Re-wrote changelog.

---
 drivers/mmc/core/sdio_irq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index f75043266984..0962a4357d54 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
 	int i, ret, count;
+	bool sdio_irq_pending = host->sdio_irq_pending;
 	unsigned char pending;
 	struct sdio_func *func;
 
@@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	if (mmc_card_suspended(card))
 		return 0;
 
+	/* Clear the flag to indicate that we have processed the IRQ. */
+	host->sdio_irq_pending = false;
+
 	/*
 	 * Optimization, if there is only 1 function interrupt registered
 	 * and we know an IRQ was signaled then call irq handler directly.
 	 * Otherwise do the full probe.
 	 */
 	func = card->sdio_single_irq;
-	if (func && host->sdio_irq_pending) {
+	if (func && sdio_irq_pending) {
 		func->irq_handler(func);
 		return 1;
 	}
@@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
 {
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
-		host->sdio_irq_pending = true;
 		process_sdio_pending_irqs(host);
 		if (host->ops->ack_sdio_irq)
 			host->ops->ack_sdio_irq(host);
@@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
 
 void sdio_signal_irq(struct mmc_host *host)
 {
+	host->sdio_irq_pending = true;
 	queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
 }
 EXPORT_SYMBOL_GPL(sdio_signal_irq);
@@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
 		if (ret)
 			break;
 		ret = process_sdio_pending_irqs(host);
-		host->sdio_irq_pending = false;
 		mmc_release_host(host);
 
 		/*
-- 
2.17.1

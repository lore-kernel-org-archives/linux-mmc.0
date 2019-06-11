From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Prevent processing SDIO IRQs when the card is suspended
Date: Tue, 11 Jun 2019 14:32:21 +0200
Message-ID: <20190611123221.11580-1-ulf.hansson@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Guenter Roeck <groeck@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Processing of SDIO IRQs must obviously be prevented while the card is
system suspended, otherwise we may end up trying to communicate with an
uninitialized SDIO card.

Reports throughout the years shows that this is not only a theoretical
problem, but a real issue. So, let's finally fix this problem, by keeping
track of the state for the card and bail out before processing the SDIO
IRQ, in case the card is suspended.

Cc: stable@vger.kernel.org
Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

This has only been compile tested so far, any help for real test on HW is
greatly appreciated.

Note that, this is only the initial part of what is needed to make power
management of SDIO card more robust, but let's start somewhere and continue to
improve things.

The next step I am looking at right now, is to make sure the SDIO IRQ is turned
off during system suspend, unless it's supported as a system wakeup (and enabled
to be used).

---
 drivers/mmc/core/sdio.c     | 7 +++++++
 drivers/mmc/core/sdio_irq.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index d1aa1c7577bb..9951295d3220 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -937,6 +937,10 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
  */
 static int mmc_sdio_suspend(struct mmc_host *host)
 {
+	/* Prevent processing of SDIO IRQs in suspended state. */
+	mmc_card_set_suspended(host->card);
+	cancel_delayed_work_sync(&host->sdio_irq_work);
+
 	mmc_claim_host(host);
 
 	if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
@@ -985,6 +989,9 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		err = sdio_enable_4bit_bus(host->card);
 	}
 
+	/* Allow SDIO IRQs to be processed again. */
+	mmc_card_clr_suspended(host->card);
+
 	if (!err && host->sdio_irqs) {
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 931e6226c0b3..9f54a259a1b3 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -34,6 +34,10 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	unsigned char pending;
 	struct sdio_func *func;
 
+	/* Don't process SDIO IRQs if the card is suspended. */
+	if (mmc_card_suspended(card))
+		return 0;
+
 	/*
 	 * Optimization, if there is only 1 function interrupt registered
 	 * and we know an IRQ was signaled then call irq handler directly.
-- 
2.17.1

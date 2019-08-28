From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts on resume
Date: Wed, 28 Aug 2019 14:46:20 -0700
Message-ID: <20190828214620.66003-2-mka@chromium.org>
References: <20190828214620.66003-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828214620.66003-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-mmc@vger.kernel.org

With commit 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs
when the card is suspended") SDIO interrupts are dropped if they
occur while the card is suspended. Dropping the interrupts can cause
problems after resume with cards that remain powered during suspend
and preserve their state. These cards may end up in an inconsistent
state since the event that triggered the interrupt is never processed
and remains pending. One example is the Bluetooth function of the
Marvell 8997, SDIO is broken on resume (for both Bluetooth and WiFi)
when processing of a pending HCI event is skipped.

For cards that remained powered during suspend check on resume if
SDIO interrupts are pending, and trigger interrupt processing if
needed.

Fixes: 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs when the card is suspended")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/mmc/core/sdio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8dd8fc32ecca..a6b4742a91c6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -975,6 +975,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 static int mmc_sdio_resume(struct mmc_host *host)
 {
 	int err = 0;
+	u8 pending = 0;
 
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
@@ -1009,6 +1010,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	/* Allow SDIO IRQs to be processed again. */
 	mmc_card_clr_suspended(host->card);
 
+	if (!mmc_card_keep_power(host))
+		goto skip_pending_irqs;
+
+	if (!sdio_get_pending_irqs(host, &pending) &&
+	    pending != 0)
+		sdio_signal_irq(host);
+
+skip_pending_irqs:
 	if (host->sdio_irqs) {
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
-- 
2.23.0.187.g17f5b7556c-goog

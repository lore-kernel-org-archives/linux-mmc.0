From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] mmc: sdio: Move code to get pending SDIO IRQs to a function
Date: Wed, 28 Aug 2019 14:46:19 -0700
Message-ID: <20190828214620.66003-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Move the code to get pending SDIO interrupts from
process_sdio_pending_irqs() to a dedicated function.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/mmc/core/sdio_irq.c | 47 ++++++++++++++++++++++++-------------
 include/linux/mmc/host.h    |  1 +
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0bcc5e83bd1a..fedc49901efd 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,35 @@
 #include "core.h"
 #include "card.h"
 
+int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
+{
+	struct mmc_card *card = host->card;
+	int ret;
+
+	WARN_ON(!host->claimed);
+
+	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
+	if (ret) {
+		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
+		       mmc_card_id(card), ret);
+		return ret;
+	}
+
+	if (*pending && mmc_card_broken_irq_polling(card) &&
+	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
+		unsigned char dummy;
+
+		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
+		 * register with a Marvell SD8797 card. A dummy CMD52 read to
+		 * function 0 register 0xff can avoid this.
+		 */
+		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdio_get_pending_irqs);
+
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -49,23 +78,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 		return 1;
 	}
 
-	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
-	if (ret) {
-		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
-		       mmc_card_id(card), ret);
+	ret = sdio_get_pending_irqs(host, &pending);
+	if (ret)
 		return ret;
-	}
-
-	if (pending && mmc_card_broken_irq_polling(card) &&
-	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
-		unsigned char dummy;
-
-		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
-		 * register with a Marvell SD8797 card. A dummy CMD52 read to
-		 * function 0 register 0xff can avoid this.
-		 */
-		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
-	}
 
 	count = 0;
 	for (i = 1; i <= 7; i++) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb7f20f..7ce0e98e3dbd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -502,6 +502,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 }
 
 void sdio_signal_irq(struct mmc_host *host);
+int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending);
 
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
-- 
2.23.0.187.g17f5b7556c-goog

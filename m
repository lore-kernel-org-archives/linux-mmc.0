From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/11] mmc: core: Move code to get pending SDIO IRQs to a function
Date: Tue,  3 Sep 2019 16:22:00 +0200
Message-ID: <20190903142207.5825-5-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

To improve code quality, let's move the code that gets pending SDIO IRQs
from process_sdio_pending_irqs() into a dedicated function.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
[Ulf: Converted function into static]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 46 ++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0bcc5e83bd1a..f75043266984 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,34 @@
 #include "core.h"
 #include "card.h"
 
+static int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
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
+
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -49,23 +77,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
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
-- 
2.17.1

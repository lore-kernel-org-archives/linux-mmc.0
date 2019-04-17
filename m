From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/7] mmc: meson-gx: remove open coded read with timeout
Date: Wed, 17 Apr 2019 22:43:49 +0200
Message-ID: <20190417204355.469-2-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

There is already a function available to poll a register until a
condition is met. Let's use it instead of open coding it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2eba507790e4..2deeacc051b1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
@@ -1100,7 +1101,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 static int meson_mmc_wait_desc_stop(struct meson_host *host)
 {
-	int loop;
 	u32 status;
 
 	/*
@@ -1110,20 +1110,10 @@ static int meson_mmc_wait_desc_stop(struct meson_host *host)
 	 * If we don't confirm the descriptor is stopped, it might raise new
 	 * IRQs after we have called mmc_request_done() which is bad.
 	 */
-	for (loop = 50; loop; loop--) {
-		status = readl(host->regs + SD_EMMC_STATUS);
-		if (status & (STATUS_BUSY | STATUS_DESC_BUSY))
-			udelay(100);
-		else
-			break;
-	}
 
-	if (status & (STATUS_BUSY | STATUS_DESC_BUSY)) {
-		dev_err(host->dev, "Timed out waiting for host to stop\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	return readl_poll_timeout(host->regs + SD_EMMC_STATUS, status,
+				  !(status & (STATUS_BUSY | STATUS_DESC_BUSY)),
+				  100, 5000);
 }
 
 static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
-- 
2.20.1

From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] mmc: meson-gx: fix irq ack
Date: Thu, 23 May 2019 16:59:50 +0200
Message-ID: <20190523145950.7030-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

While cleaning the ISR of the meson-gx and acking only raised irqs,
the ack of the irq was moved at the very last stage of the function.

This was stable during the initial tests but it triggered issues with
hs200, under specific loads (like booting android). Acking the irqs
after calling the mmc_request_done() causes the problem.

Moving the ack back to the original place solves the issue. Since the
irq is edge triggered, it does not hurt to ack irq even earlier, so
let's do it early in the ISR.

Fixes: 9c5fdb07a28d ("mmc: meson-gx: ack only raised irq")
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6ef465304052..cb3f6811d69a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -873,6 +873,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
+	/* ack all raised interrupts */
+	writel(status, host->regs + SD_EMMC_STATUS);
+
 	cmd = host->cmd;
 	data = cmd->data;
 	cmd->error = 0;
@@ -919,9 +922,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	/* ack all raised interrupts */
-	writel(status, host->regs + SD_EMMC_STATUS);
-
 	return ret;
 }
 
-- 
2.20.1

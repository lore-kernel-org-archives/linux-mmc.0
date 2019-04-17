From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/7] mmc: meson-gx: ack only raised irq
Date: Wed, 17 Apr 2019 22:43:50 +0200
Message-ID: <20190417204355.469-3-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is merely a clean up. It makes sense to only ack raised irqs
instead of acking everything all the time.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2deeacc051b1..8b690ecde4c5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1082,9 +1082,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	}
 
 out:
-	/* ack all enabled interrupts */
-	writel(irq_en, host->regs + SD_EMMC_STATUS);
-
 	if (cmd->error) {
 		/* Stop desc in case of errors */
 		u32 start = readl(host->regs + SD_EMMC_START);
@@ -1096,6 +1093,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
+	/* ack all raised interrupts */
+	writel(status, host->regs + SD_EMMC_STATUS);
+
 	return ret;
 }
 
-- 
2.20.1

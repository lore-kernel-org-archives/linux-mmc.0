From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 04/14] mmc: meson-gx: use _irqsave variant of spinlock
Date: Fri,  4 Aug 2017 19:43:43 +0200
Message-ID: <20170804174353.16486-5-jbrunet@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804174353.16486-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

spinlock used in interrupt handler should use the _irqsave variant

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8a74a048db88..a399fbd415f4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -727,6 +727,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	struct mmc_command *cmd;
 	struct mmc_data *data;
 	u32 irq_en, status, raw_status;
+	unsigned long flag;
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (WARN_ON(!host))
@@ -739,7 +740,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 	data = cmd->data;
 
-	spin_lock(&host->lock);
+	spin_lock_irqsave(&host->lock, flag);
 	irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
 	status = raw_status & irq_en;
@@ -806,7 +807,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	spin_unlock(&host->lock);
+	spin_unlock_irqrestore(&host->lock, flag);
 	return ret;
 }
 
-- 
2.9.4

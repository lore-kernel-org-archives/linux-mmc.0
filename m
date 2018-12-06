From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/4] mmc: meson-gx: remove useless lock
Date: Thu,  6 Dec 2018 16:18:26 +0100
Message-ID: <20181206151828.24417-3-jbrunet@baylibre.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The spinlock is only used within the irq handler so it does not
seem very useful.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index fcb5d693c897..5cc31e434ca1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
-#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -159,7 +158,6 @@ struct meson_host {
 	struct	mmc_host	*mmc;
 	struct	mmc_command	*cmd;
 
-	spinlock_t lock;
 	void __iomem *regs;
 	struct clk *core_clk;
 	struct clk *mmc_clk;
@@ -1040,8 +1038,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
-	spin_lock(&host->lock);
-
 	cmd = host->cmd;
 	data = cmd->data;
 	cmd->error = 0;
@@ -1091,7 +1087,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	spin_unlock(&host->lock);
 	return ret;
 }
 
@@ -1244,8 +1239,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
-	spin_lock_init(&host->lock);
-
 	/* Get regulators and the supported OCR mask */
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
-- 
2.19.2

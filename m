From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: tmio: Fix hang during suspend
Date: Thu, 14 Aug 2014 17:23:53 +0200
Message-ID: <1408029833-6970-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

On R-Car Gen 2, the SDHI registers cannot be accessed while the SDHI
module clock is disabled. Doing so will cause a lock-up.

When suspending, enable the module clock before disabling the SDHI
interrupts, and disable the clock again afterwards.

This fixes suspend and resume on r8a7791/koelsch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/tmio_mmc_pio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index faf0924e71cb..83192420a7e3 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1147,8 +1147,18 @@ int tmio_mmc_host_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_data *pdata = host->pdata;
+
+	if (pdata->clk_enable) {
+		unsigned int f;
+		pdata->clk_enable(host->pdev, &f);
+	}
 
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+
+	if (pdata->clk_disable)
+		pdata->clk_disable(host->pdev);
+
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_suspend);
-- 
1.9.1

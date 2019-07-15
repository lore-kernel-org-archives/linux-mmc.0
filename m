From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] mmc: host: sdhci: Fix the incorrect soft reset operation when runtime resuming
Date: Mon, 15 Jul 2019 18:58:49 +0800
Message-ID: <4c5812f54e5094fa54a85bdc86687a523df254b3.1563184923.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: zhang.lyra@gmail.com, orsonzhai@gmail.com, linus.walleij@linaro.org, baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In sdhci_runtime_resume_host() function, we will always do software reset
for all, but according to the specification, we should issue reset command
and reinitialize the SD/eMMC card. However, we only do reinitialize the
SD/eMMC card when the SD/eMMC card are power down during runtime suspend.

Thus for those platforms that do not power down the SD/eMMC card during
runtime suspend, we should not do software reset for all. To fix this
issue, we can add one condition to validate the MMC_CAP_AGGRESSIVE_PM
to decide if we can do software reset for all or just reset command
and data lines.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9715834..470c5e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3333,7 +3333,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	sdhci_init(host, 0);
+	sdhci_init(host, !(mmc->caps & MMC_CAP_AGGRESSIVE_PM));
 
 	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
 	    mmc->ios.power_mode != MMC_POWER_OFF) {
-- 
1.7.9.5

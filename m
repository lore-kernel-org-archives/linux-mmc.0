From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2] mmc: sdhci-of-at91: fix wake-up issue when using runtime pm
Date: Thu, 17 Mar 2016 14:54:34 +0100
Message-ID: <1458222874-23765-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:32817 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcCQNyK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2016 09:54:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

It is impossible to wake-up on card detect event because when sdhci
controller is runtime suspended, it is assumed that all clocks are
disabled so we can't get irqs.
If the device is removable and there is no gpio to manage the card
detection then polling is used. It doesn't mean card detection is broken.
It is curently we only way to wake-up on card event if using runtime pm.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Changes:
- v2:
  - remove SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk if set by the broken-cd
  property.

 drivers/mmc/host/sdhci-of-at91.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 35c02fc..2703aa9 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -204,6 +205,25 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	if (ret)
 		goto pm_runtime_disable;
 
+	/*
+	 * When calling sdhci_runtime_suspend_host(), the sdhci layer makes
+	 * the assumption that all the clocks of the controller are disabled.
+	 * It means we can't get irq from it when it is runtime suspended.
+	 * For that reason, it is not planned to wake-up on a card detect irq
+	 * from the controller.
+	 * If we want to use runtime PM and to be able to wake-up on card
+	 * insertion, we have to use a GPIO for the card detection or we can
+	 * use polling. Be aware that using polling will resume/suspend the
+	 * controller between each attempt.
+	 * Disable SDHCI_QUIRK_BROKEN_CARD_DETECTION to be sure nobody tries
+	 * to enable polling via device tree with broken-cd property.
+	 */
+	if (!(host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
+	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc))) {
+		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+	}
+
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
-- 
2.5.0


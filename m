From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] mmc: arasan: Add polling card detect
Date: Thu, 20 Apr 2017 11:14:48 +0530
Message-ID: <1492667088-20866-2-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1492667088-20866-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:36032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1765641AbdDTFo4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 01:44:56 -0400
In-Reply-To: <1492667088-20866-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add MMC_CAP_NEEDS_POLL flag for card detect if
no gpio is passed otherwise use gpio as card detect.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 812e75a..7e02190 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -23,6 +23,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -728,6 +730,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_add_host;
 
+	if (mmc_card_is_removable(host->mmc) &&
+	    mmc_gpio_get_cd(host->mmc) < 0) {
+		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+	}
+
 	pm_runtime_put(&pdev->dev);
 	return 0;
 
-- 
2.7.4


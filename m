From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Fri, 11 Sep 2015 16:54:58 +0800
Message-ID: <1441961698-10516-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:57120 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbIKI5U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2015 04:57:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, S?ren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch adds Generic PHY access for sdhci-of-arasan. Driver
can get PHY handler from dt-binding, and power-on/init the PHY.
Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 621c3f4..fdd71c7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -21,6 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/phy/phy.h>
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
@@ -35,6 +36,7 @@
  */
 struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
+	struct phy	*phy;
 };
 
 static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
@@ -67,6 +69,62 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
 
 #ifdef CONFIG_PM_SLEEP
 /**
+  * sdhci_arasan_suspend_phy - Suspend phy method for the driver
+  * @phy:        Handler of phy structure
+  * Returns 0 on success and error value on error
+  *
+  * Put the phy in a deactive state.
+  */
+static int sdhci_arasan_suspend_phy(struct phy *phy)
+{
+	int ret;
+
+	ret = phy_exit(phy);
+	if (ret < 0)
+		goto err_phy_exit;
+
+	ret = phy_power_off(phy);
+	if (ret < 0)
+		goto err_phy_pwr_off;
+
+	return 0;
+
+err_phy_pwr_off:
+	phy_power_on(phy);
+err_phy_exit:
+	phy_init(phy);
+	return ret;
+}
+
+/**
+  * sdhci_arasan_resume_phy - Resume phy method for the driver
+  * @phy:        Handler of phy structure
+  * Returns 0 on success and error value on error
+  *
+  * Put the phy in a active state.
+  */
+static int sdhci_arasan_resume_phy(struct phy *phy)
+{
+	int ret;
+
+	ret = phy_power_on(phy);
+	if (ret < 0)
+		goto err_phy_pwr_on;
+
+	ret = phy_init(phy);
+	if (ret < 0)
+		goto err_phy_init;
+
+	return 0;
+
+err_phy_init:
+	phy_exit(phy);
+err_phy_pwr_on:
+	phy_power_off(phy);
+	return ret;
+}
+
+/**
  * sdhci_arasan_suspend - Suspend method for the driver
  * @dev:	Address of the device structure
  * Returns 0 on success and error value on error
@@ -88,6 +146,12 @@ static int sdhci_arasan_suspend(struct device *dev)
 	clk_disable(pltfm_host->clk);
 	clk_disable(sdhci_arasan->clk_ahb);
 
+	if (sdhci_arasan->phy) {
+		ret = sdhci_arasan_suspend_phy(sdhci_arasan->phy);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -119,6 +183,12 @@ static int sdhci_arasan_resume(struct device *dev)
 		return ret;
 	}
 
+	if (sdhci_arasan->phy) {
+		ret = sdhci_arasan_resume_phy(sdhci_arasan->phy);
+		if (ret < 0)
+			return ret;
+	}
+
 	return sdhci_resume_host(host);
 }
 #endif /* ! CONFIG_PM_SLEEP */
@@ -163,6 +233,26 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_dis_ahb;
 	}
 
+	sdhci_arasan->phy = devm_phy_get(&pdev->dev, "phy_arasan");
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		ret = phy_power_on(sdhci_arasan->phy);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "phy_power_on err.\n");
+			phy_power_off(sdhci_arasan->phy);
+			goto clk_dis_ahb;
+		}
+
+		ret = phy_init(sdhci_arasan->phy);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "phy_init err.\n");
+			phy_exit(sdhci_arasan->phy);
+			phy_power_off(sdhci_arasan->phy);
+			goto clk_dis_ahb;
+		}
+	} else {
+		sdhci_arasan->phy = NULL;
+	}
+
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
-- 
2.3.7



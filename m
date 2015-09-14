From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Mon, 14 Sep 2015 14:29:21 +0800
Message-ID: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:49335 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbINGby (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 02:31:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch adds Generic PHY access for sdhci-of-arasan. Driver
can get PHY handler from dt-binding, and power-on/init the PHY.
Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
Currently, it's just mandatory for arasan,sdhci-5.1.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Serise-changes: 2
- Keep phy as a mandatory requirement for arasan,sdhci-5.1

---

Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 75379cb..2c13ef8 100644
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
@@ -70,6 +72,62 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
 
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
@@ -91,6 +149,12 @@ static int sdhci_arasan_suspend(struct device *dev)
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
 
@@ -122,6 +186,12 @@ static int sdhci_arasan_resume(struct device *dev)
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
@@ -166,6 +236,33 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_dis_ahb;
 	}
 
+	sdhci_arasan->phy = NULL;
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "arasan,sdhci-5.1")) {
+		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
+						 "phy_arasan");
+		if (IS_ERR(sdhci_arasan->phy)) {
+			ret = -ENODEV;
+			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
+			goto clk_dis_ahb;
+		}
+
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
+	}
+
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
-- 
2.3.7



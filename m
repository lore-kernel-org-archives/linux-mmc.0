From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/3] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Tue, 20 Oct 2015 15:05:18 +0800
Message-ID: <1445324718-31407-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds Generic PHY access for sdhci-of-arasan. Driver
can get PHY handler from dt-binding, and power-on/init the PHY.
Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
Currently, it's just mandatory for arasan,sdhci-5.1.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Serise-changes: 3
- remove phy_init/exit for suspend/resume
- adjust phy_int/power_on seq to make code more reasonable
- simplify suspend/resume_phy

Serise-changes: 2
- Keep phy as a mandatory requirement for arasan,sdhci-5.1

---

Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 87 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 75379cb..85bd0f9d 100644
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
@@ -70,6 +72,42 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
 
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
+	int ret = 0;
+
+	ret = phy_power_off(phy);
+	if (ret)
+		phy_power_on(phy);
+
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
+	int ret = 0;
+
+	ret = phy_power_on(phy);
+	if (ret)
+		phy_power_off(phy);
+
+	return ret;
+}
+
+/**
  * sdhci_arasan_suspend - Suspend method for the driver
  * @dev:	Address of the device structure
  * Returns 0 on success and error value on error
@@ -88,6 +126,15 @@ static int sdhci_arasan_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		ret = sdhci_arasan_suspend_phy(sdhci_arasan->phy);
+		if (ret) {
+			dev_err(dev, "Cannot suspend phy.\n");
+			sdhci_resume_host(host);
+			return ret;
+		}
+	}
+
 	clk_disable(pltfm_host->clk);
 	clk_disable(sdhci_arasan->clk_ahb);
 
@@ -122,6 +169,16 @@ static int sdhci_arasan_resume(struct device *dev)
 		return ret;
 	}
 
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		ret = sdhci_arasan_resume_phy(sdhci_arasan->phy);
+		if (ret) {
+			dev_err(dev, "Cannot resume phy.\n");
+			clk_disable(sdhci_arasan->clk_ahb);
+			clk_disable(pltfm_host->clk);
+			return ret;
+		}
+	}
+
 	return sdhci_resume_host(host);
 }
 #endif /* ! CONFIG_PM_SLEEP */
@@ -166,6 +223,33 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
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
+		ret = phy_init(sdhci_arasan->phy);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "phy_init err.\n");
+			phy_exit(sdhci_arasan->phy);
+			goto clk_dis_ahb;
+		}
+
+		ret = phy_power_on(sdhci_arasan->phy);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "phy_power_on err.\n");
+			phy_power_off(sdhci_arasan->phy);
+			phy_exit(sdhci_arasan->phy);
+			goto clk_dis_ahb;
+		}
+	}
+
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
@@ -210,6 +294,9 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
 
+	if (!IS_ERR(sdhci_arasan->phy))
+		phy_exit(sdhci_arasan->phy);
+
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 
 	return sdhci_pltfm_unregister(pdev);
-- 
2.3.7

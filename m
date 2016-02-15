From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 2/2] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Mon, 15 Feb 2016 17:42:05 +0800
Message-ID: <1455529325-7538-1-git-send-email-shawn.lin@rock-chips.com>
References: <1455529288-7454-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455529288-7454-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds Generic PHY access for sdhci-of-arasan. Driver
can get PHY handler from dt-binding, and power-on/init the PHY.
Currently, it's just mandatory for arasan,sdhci-5.1.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Serise-changes: 5
- remove rpm support from this serise
- fix some err case for handling phy

Serise-changes: 4
- remove suspend/resume_phy
- add err handle label for system PM callback
- fix comments of struct sdhci_arasan_data and system PM
  callback suggested by Michal

Serise-changes: 3
- remove phy_init/exit for suspend/resume
- adjust phy_int/power_on seq to make code more reasonable
- simplify suspend/resume_phy

Serise-changes: 2
- Keep phy as a mandatory requirement for arasan,sdhci-5.1

---

Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 66 +++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 5d9fdb3..cc40b1d 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -21,6 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/phy/phy.h>
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
@@ -32,9 +33,11 @@
 /**
  * struct sdhci_arasan_data
  * @clk_ahb:	Pointer to the AHB clock
+ * @phy: Pointer to the generic phy
  */
 struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
+	struct phy	*phy;
 };
 
 static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
@@ -72,7 +75,7 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
  * @dev:	Address of the device structure
- * Returns 0 on success and error value on error
+ * Return: 0 on success and error value on error
  *
  * Put the device in a low power state.
  */
@@ -88,6 +91,14 @@ static int sdhci_arasan_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		ret = phy_power_off(sdhci_arasan->phy);
+		if (ret) {
+			dev_err(dev, "Cannot power off phy.\n");
+			return ret;
+		}
+	}
+
 	clk_disable(pltfm_host->clk);
 	clk_disable(sdhci_arasan->clk_ahb);
 
@@ -97,7 +108,7 @@ static int sdhci_arasan_suspend(struct device *dev)
 /**
  * sdhci_arasan_resume - Resume method for the driver
  * @dev:	Address of the device structure
- * Returns 0 on success and error value on error
+ * Return: 0 on success and error value on error
  *
  * Resume operation after suspend
  */
@@ -118,11 +129,24 @@ static int sdhci_arasan_resume(struct device *dev)
 	ret = clk_enable(pltfm_host->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable SD clock.\n");
-		clk_disable(sdhci_arasan->clk_ahb);
-		return ret;
+		goto err_clk_en;
+	}
+
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		ret = phy_power_on(sdhci_arasan->phy);
+		if (ret) {
+			dev_err(dev, "Cannot power on phy.\n");
+			goto err_phy_power;
+		}
 	}
 
 	return sdhci_resume_host(host);
+
+err_phy_power:
+	clk_disable(pltfm_host->clk);
+err_clk_en:
+	clk_disable(sdhci_arasan->clk_ahb);
+	return ret;
 }
 #endif /* ! CONFIG_PM_SLEEP */
 
@@ -183,6 +207,30 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_disable_all;
 	}
 
+	sdhci_arasan->phy = ERR_PTR(-ENODEV);
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "arasan,sdhci-5.1")) {
+		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
+						 "phy_arasan");
+		if (IS_ERR(sdhci_arasan->phy)) {
+			ret = PTR_ERR(sdhci_arasan->phy);
+			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
+			goto clk_disable_all;
+		}
+
+		ret = phy_init(sdhci_arasan->phy);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "phy_init err.\n");
+			goto clk_disable_all;
+		}
+
+		ret = phy_power_on(sdhci_arasan->phy);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "phy_power_on err.\n");
+			goto err_phy_power;
+		}
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_pltfm_free;
@@ -190,7 +238,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	return 0;
 
 err_pltfm_free:
+	if (!IS_ERR(sdhci_arasan->phy))
+		phy_power_off(sdhci_arasan->phy);
 	sdhci_pltfm_free(pdev);
+err_phy_power:
+	if (!IS_ERR(sdhci_arasan->phy))
+		phy_exit(sdhci_arasan->phy);
 clk_disable_all:
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
@@ -205,6 +258,11 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
 
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		phy_power_off(sdhci_arasan->phy);
+		phy_exit(sdhci_arasan->phy);
+	}
+
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 
 	return sdhci_pltfm_unregister(pdev);
-- 
2.3.7

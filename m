From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 4/4] mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
Date: Mon,  7 Mar 2016 23:39:19 +0800
Message-ID: <1457365159-23414-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds Generic PHY access for sdhci-of-arasan. Driver
can get PHY handler from dt-binding, and power-on/init the PHY.
Currently, it's just mandatory for arasan,sdhci-5.1.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 57 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 91b7c62..2e482b1 100644
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
@@ -88,6 +91,15 @@ static int sdhci_arasan_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		ret = phy_power_off(sdhci_arasan->phy);
+		if (ret) {
+			dev_err(dev, "Cannot power off phy.\n");
+			sdhci_resume_host(host);
+			return ret;
+		}
+	}
+
 	clk_disable(pltfm_host->clk);
 	clk_disable(sdhci_arasan->clk_ahb);
 
@@ -121,6 +133,14 @@ static int sdhci_arasan_resume(struct device *dev)
 		return ret;
 	}
 
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		ret = phy_power_on(sdhci_arasan->phy);
+		if (ret) {
+			dev_err(dev, "Cannot power on phy.\n");
+			return ret;
+		}
+	}
+
 	return sdhci_resume_host(host);
 }
 #endif /* ! CONFIG_PM_SLEEP */
@@ -179,12 +199,42 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
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
-		goto clk_disable_all;
+		goto err_add_host;
 
 	return 0;
 
+err_add_host:
+	if (!IS_ERR(sdhci_arasan->phy))
+		phy_power_off(sdhci_arasan->phy);
+err_phy_power:
+	if (!IS_ERR(sdhci_arasan->phy))
+		phy_exit(sdhci_arasan->phy);
 clk_disable_all:
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
@@ -202,6 +252,11 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
 
+	if (!IS_ERR(sdhci_arasan->phy)) {
+		phy_power_off(sdhci_arasan->phy);
+		phy_exit(sdhci_arasan->phy);
+	}
+
 	ret = sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
-- 
2.3.7

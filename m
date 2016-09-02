From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 2/4] mmc: sdhci-of-arasan: Control clock for accessing syscon
Date: Fri,  2 Sep 2016 08:54:39 +0800
Message-ID: <1472777681-16656-3-git-send-email-shawn.lin@rock-chips.com>
References: <1472777681-16656-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:40733 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbcIBBAf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 21:00:35 -0400
In-Reply-To: <1472777681-16656-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

In the eariler commit 65820199272d ("Documentation: mmc:
sdhci-of-arasan: Add soc-ctl-syscon for corecfg regs"), we
introduced syscon to control corecfg_* stuff provided by
arasan. But given that we may need to ungate the clock for
accessing corecfg_*, it not so perfect as it depends on
whether specific clock driver disables it if not referenced.
Meanwhile, if we don't need arasan contoller to work anymore,
there is no reason to still enable it. So let's control this
clock when needed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Tested-by: Ziyuan Xu <xzy.xu@rock-chips.com>
---

Changes in v3:
- return failure if failing to enable clk_syscon

Changes in v2:
- assign NULL to clk_syscon if it's not deferral error.

 drivers/mmc/host/sdhci-of-arasan.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0b3a9cf..767d4b0 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -78,6 +78,7 @@ struct sdhci_arasan_soc_ctl_map {
  * struct sdhci_arasan_data
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
+ * @clk_syscon:		Pointer to the optional clock for accessing syscon
  * @phy:		Pointer to the generic phy
  * @is_phy_on:		True if the PHY is on; false if not.
  * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
@@ -88,6 +89,7 @@ struct sdhci_arasan_soc_ctl_map {
 struct sdhci_arasan_data {
 	struct sdhci_host *host;
 	struct clk	*clk_ahb;
+	struct clk	*clk_syscon;
 	struct phy	*phy;
 	bool		is_phy_on;
 
@@ -290,6 +292,7 @@ static int sdhci_arasan_suspend(struct device *dev)
 
 	clk_disable(pltfm_host->clk);
 	clk_disable(sdhci_arasan->clk_ahb);
+	clk_disable(sdhci_arasan->clk_syscon);
 
 	return 0;
 }
@@ -309,6 +312,12 @@ static int sdhci_arasan_resume(struct device *dev)
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	ret = clk_enable(sdhci_arasan->clk_syscon);
+	if (ret) {
+		dev_err(dev, "Cannot enable syscon clock.\n");
+		return ret;
+	}
+
 	ret = clk_enable(sdhci_arasan->clk_ahb);
 	if (ret) {
 		dev_err(dev, "Cannot enable AHB clock.\n");
@@ -528,26 +537,42 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 					ret);
 			goto err_pltfm_free;
 		}
+
+		sdhci_arasan->clk_syscon = devm_clk_get(&pdev->dev,
+							"clk_syscon");
+		if (IS_ERR(sdhci_arasan->clk_syscon)) {
+			ret = PTR_ERR(sdhci_arasan->clk_syscon);
+			if (ret == -EPROBE_DEFER)
+				goto err_pltfm_free;
+			else
+				sdhci_arasan->clk_syscon = NULL;
+		}
+
+		ret = clk_prepare_enable(sdhci_arasan->clk_syscon);
+		if (ret) {
+			dev_err(&pdev->dev, "Unable to enable syscon clock.\n");
+			goto err_pltfm_free;
+		}
 	}
 
 	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
 		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
 		ret = PTR_ERR(sdhci_arasan->clk_ahb);
-		goto err_pltfm_free;
+		goto clk_dis_syscon;
 	}
 
 	clk_xin = devm_clk_get(&pdev->dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
 		dev_err(&pdev->dev, "clk_xin clock not found.\n");
 		ret = PTR_ERR(clk_xin);
-		goto err_pltfm_free;
+		goto clk_dis_syscon;
 	}
 
 	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
-		goto err_pltfm_free;
+		goto clk_dis_syscon;
 	}
 
 	ret = clk_prepare_enable(clk_xin);
@@ -607,6 +632,8 @@ clk_disable_all:
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
+clk_dis_syscon:
+	clk_disable_unprepare(sdhci_arasan->clk_syscon);
 err_pltfm_free:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -631,6 +658,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	ret = sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
+	clk_disable_unprepare(sdhci_arasan->clk_syscon);
 
 	return ret;
 }
-- 
2.3.7



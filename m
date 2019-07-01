From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 04/11] mmc: sdhci-of-arasan: Separate out clk related data to another structure
Date: Mon,  1 Jul 2019 10:59:44 +0530
Message-ID: <1561958991-21935-5-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com, christoph.muellner@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org, scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk, tony.xie@rock-chips.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

To improve the code readability, use two different structs, one for
clock provider data and one for mmc platform data.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index d60a2e8..c7586f5 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -72,13 +72,22 @@ struct sdhci_arasan_soc_ctl_map {
 };
 
 /**
+ * struct sdhci_arasan_clk_data
+ * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
+ * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
+ */
+struct sdhci_arasan_clk_data {
+	struct clk_hw	sdcardclk_hw;
+	struct clk      *sdcardclk;
+};
+
+/**
  * struct sdhci_arasan_data
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
  * @phy:		Pointer to the generic phy
+ * @clk_data:		Struct for the Arasan Controller Clock Data.
  * @is_phy_on:		True if the PHY is on; false if not.
- * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
- * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
  * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
  */
@@ -89,8 +98,7 @@ struct sdhci_arasan_data {
 	bool		is_phy_on;
 
 	bool		has_cqe;
-	struct clk_hw	sdcardclk_hw;
-	struct clk      *sdcardclk;
+	struct sdhci_arasan_clk_data clk_data;
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
@@ -505,8 +513,10 @@ static unsigned long sdhci_arasan_sdcardclk_recalc_rate(struct clk_hw *hw,
 						      unsigned long parent_rate)
 
 {
+	struct sdhci_arasan_clk_data *clk_data =
+		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
 	struct sdhci_arasan_data *sdhci_arasan =
-		container_of(hw, struct sdhci_arasan_data, sdcardclk_hw);
+		container_of(clk_data, struct sdhci_arasan_data, clk_data);
 	struct sdhci_host *host = sdhci_arasan->host;
 
 	return host->mmc->actual_clock;
@@ -618,6 +628,7 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 				       struct clk *clk_xin,
 				       struct device *dev)
 {
+	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
 	struct device_node *np = dev->of_node;
 	struct clk_init_data sdcardclk_init;
 	const char *parent_clk_name;
@@ -640,25 +651,25 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
 	sdcardclk_init.ops = &arasan_sdcardclk_ops;
 
-	sdhci_arasan->sdcardclk_hw.init = &sdcardclk_init;
-	ret = devm_clk_hw_register(dev, &sdhci_arasan->sdcardclk_hw);
+	clk_data->sdcardclk_hw.init = &sdcardclk_init;
+	ret = devm_clk_hw_register(dev, &clk_data->sdcardclk_hw);
 	if (ret) {
 		dev_err(dev, "Failed to register SD clk_hw\n");
 		return ret;
 	}
-	sdhci_arasan->sdcardclk_hw.init = NULL;
+	clk_data->sdcardclk_hw.init = NULL;
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get,
-				     &sdhci_arasan->sdcardclk_hw);
+				     &clk_data->sdcardclk_hw);
 	if (ret) {
 		dev_err(dev, "Failed to add clock provider\n");
 		return ret;
 	}
 
-	sdhci_arasan->sdcardclk = devm_clk_get(dev, "clk_sdcard");
-	if (IS_ERR(sdhci_arasan->sdcardclk)) {
+	clk_data->sdcardclk = devm_clk_get(dev, "clk_sdcard");
+	if (IS_ERR(clk_data->sdcardclk)) {
 		dev_err(dev, "sdcardclk clock not found.\n");
-		ret = PTR_ERR(sdhci_arasan->sdcardclk);
+		ret = PTR_ERR(clk_data->sdcardclk);
 	}
 
 	return ret;
-- 
2.1.1

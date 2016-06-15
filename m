From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2.1 07/11] mmc: sdhci-of-arasan: Add ability to export card clock
Date: Wed, 15 Jun 2016 09:37:51 -0700
Message-ID: <1466008675-9357-8-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34712 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcFOQiX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 12:38:23 -0400
Received: by mail-pf0-f171.google.com with SMTP id 62so10388774pfd.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2016 09:38:23 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, groeck@chromium.org, Douglas Anderson <dianders@chromium.org>, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, geert@linux-m68k.org, wsa+renesas@sang-engineering.com, swarren@wwwdotorg.org, stefan.wahren@i2se.com, luisbg@osg.samsung.com, andrei.pistirica@microchip.com, chaotian.jing@mediatek.com, ludovic.desroches@atmel.com, yangbo.lu@freescale.com, horms+renesas@verge.net.au, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
with arasan,sdhci-5.1) need to know the card clock in order to function
properly.  Let's add the ability to expose this clock.  Any PHY that
needs to know the clock rate can add a reference and query the clock
rate.

At the moment we register a CLK_GET_RATE_NOCACHE clock that simply
allows querying the clock.  This allows us to be less intrusive with
regards to the main SDHCI driver, which has complex logic for adjusting
the SD clock.  Right now we always fully power cycle the PHY when the
clock changes and that gives the PHY a good chance to query our clock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Note: just sending the one quick fix as v2.1.  If further spins are
needed I'll send out a full v3.

Changes in v2.1:
- Add dependency on COMMON_CLK (Guenter Roeck)

Changes in v2: None

 drivers/mmc/host/Kconfig           |   1 +
 drivers/mmc/host/sdhci-of-arasan.c | 125 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0aa484c10c0a..6725dc9e644b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -122,6 +122,7 @@ config MMC_SDHCI_OF_ARASAN
 	tristate "SDHCI OF support for the Arasan SDHCI controllers"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
+	depends on COMMON_CLK
 	help
 	  This selects the Arasan Secure Digital Host Controller Interface
 	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1286fe8905dc..678f316702e0 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -19,6 +19,7 @@
  * your option) any later version.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -73,17 +74,24 @@ struct sdhci_arasan_soc_ctl_map {
 
 /**
  * struct sdhci_arasan_data
+ * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
  * @phy:		Pointer to the generic phy
  * @phy_on:		True if the PHY is turned on.
+ * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
+ * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
  * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
  * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
  */
 struct sdhci_arasan_data {
+	struct sdhci_host *host;
 	struct clk	*clk_ahb;
 	struct phy	*phy;
 	bool		phy_on;
 
+	struct clk_hw	sdcardclk_hw;
+	struct clk      *sdcardclk;
+
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
 };
@@ -307,6 +315,31 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
 
 /**
+ * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
+ *
+ * Return the current actual rate of the SD card clock.  This can be used
+ * to communicate with out PHY.
+ *
+ * @hw:			Pointer to the hardware clock structure.
+ * @parent_rate		The parent rate (should be rate of clk_xin).
+ * Returns the card clock rate.
+ */
+static unsigned long sdhci_arasan_sdcardclk_recalc_rate(struct clk_hw *hw,
+						      unsigned long parent_rate)
+
+{
+	struct sdhci_arasan_data *sdhci_arasan =
+		container_of(hw, struct sdhci_arasan_data, sdcardclk_hw);
+	struct sdhci_host *host = sdhci_arasan->host;
+
+	return host->mmc->actual_clock;
+}
+
+static const struct clk_ops arasan_sdcardclk_ops = {
+	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
+};
+
+/**
  * sdhci_arasan_update_baseclkfreq - Set corecfg_baseclkfreq
  *
  * The corecfg_baseclkfreq is supposed to contain the MHz of clk_xin.  This
@@ -345,6 +378,83 @@ static void sdhci_arasan_update_baseclkfreq(struct sdhci_host *host)
 	sdhci_arasan_syscon_write(host, &soc_ctl_map->baseclkfreq, mhz);
 }
 
+/**
+ * sdhci_arasan_register_sdclk - Register the sdclk for a PHY to use
+ *
+ * Some PHY devices need to know what the actual card clock is.  In order for
+ * them to find out, we'll provide a clock through the common clock framework
+ * for them to query.
+ *
+ * Note: without seriously re-architecting SDHCI's clock code and testing on
+ * all platforms, there's no way to create a totally beautiful clock here
+ * with all clock ops implemented.  Instead, we'll just create a clock that can
+ * be queried and set the CLK_GET_RATE_NOCACHE attribute to tell common clock
+ * framework that we're doing things behind its back.  This should be sufficient
+ * to create nice clean device tree bindings and later (if needed) we can try
+ * re-architecting SDHCI if we see some benefit to it.
+ *
+ * @sdhci_arasan:	Our private data structure.
+ * @clk_xin:		Pointer to the functional clock
+ * @dev:		Pointer to our struct device.
+ * Returns 0 on success and error value on error
+ */
+static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
+				       struct clk *clk_xin,
+				       struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct clk_init_data sdcardclk_init;
+	const char *parent_clk_name;
+	int ret;
+
+	/* Providing a clock to the PHY is optional; no error if missing */
+	if (!of_find_property(np, "#clock-cells", NULL))
+		return 0;
+
+	ret = of_property_read_string_index(np, "clock-output-names", 0,
+					    &sdcardclk_init.name);
+	if (ret) {
+		dev_err(dev, "DT has #clock-cells but no clock-output-names\n");
+		return ret;
+	}
+
+	parent_clk_name = __clk_get_name(clk_xin);
+	sdcardclk_init.parent_names = &parent_clk_name;
+	sdcardclk_init.num_parents = 1;
+	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
+	sdcardclk_init.ops = &arasan_sdcardclk_ops;
+
+	sdhci_arasan->sdcardclk_hw.init = &sdcardclk_init;
+	sdhci_arasan->sdcardclk =
+		devm_clk_register(dev, &sdhci_arasan->sdcardclk_hw);
+	sdhci_arasan->sdcardclk_hw.init = NULL;
+
+	ret = of_clk_add_provider(np, of_clk_src_simple_get,
+				  sdhci_arasan->sdcardclk);
+	if (ret)
+		dev_err(dev, "Failed to add clock provider\n");
+
+	return ret;
+}
+
+/**
+ * sdhci_arasan_unregister_sdclk - Undoes sdhci_arasan_register_sdclk()
+ *
+ * Should be called any time we're exiting and sdhci_arasan_register_sdclk()
+ * returned success.
+ *
+ * @dev:		Pointer to our struct device.
+ */
+static void sdhci_arasan_unregister_sdclk(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+
+	if (!of_find_property(np, "#clock-cells", NULL))
+		return;
+
+	of_clk_del_provider(dev->of_node);
+}
+
 static int sdhci_arasan_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -362,6 +472,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	sdhci_arasan->host = host;
 
 	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
 	sdhci_arasan->soc_ctl_map = match->data;
@@ -411,10 +522,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	sdhci_arasan_update_baseclkfreq(host);
 
+	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
+	if (ret)
+		goto clk_disable_all;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
 		dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
-		goto clk_disable_all;
+		goto unreg_clk;
 	}
 
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
@@ -425,13 +540,13 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		if (IS_ERR(sdhci_arasan->phy)) {
 			ret = PTR_ERR(sdhci_arasan->phy);
 			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
-			goto clk_disable_all;
+			goto unreg_clk;
 		}
 
 		ret = phy_init(sdhci_arasan->phy);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "phy_init err.\n");
-			goto clk_disable_all;
+			goto unreg_clk;
 		}
 
 		host->mmc_host_ops.hs400_enhanced_strobe =
@@ -447,6 +562,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 err_add_host:
 	if (!IS_ERR(sdhci_arasan->phy))
 		phy_exit(sdhci_arasan->phy);
+unreg_clk:
+	sdhci_arasan_unregister_sdclk(&pdev->dev);
 clk_disable_all:
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
@@ -469,6 +586,8 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 		phy_exit(sdhci_arasan->phy);
 	}
 
+	sdhci_arasan_unregister_sdclk(&pdev->dev);
+
 	ret = sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
-- 
2.8.0.rc3.226.g39d4020


From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3 11/15] mmc: sdhci-of-arasan: Add ability to export card
 clock
Date: Mon, 20 Jun 2016 10:56:50 -0700
Message-ID: <1466445414-11974-12-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466445414-11974-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yangbo.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, andrei.pistirica-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

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

Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
Changes in v3:
- Add dependency on COMMON_CLK (actually in v2.1) (Guenter Roeck)
- Add collected tags

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

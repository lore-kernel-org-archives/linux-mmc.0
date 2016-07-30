From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/5] mmc: sunxi: sun4i / sun5i do not have sample clocks
Date: Sat, 30 Jul 2016 16:25:47 +0200
Message-ID: <1469888748-26085-5-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-mmc@vger.kernel.org

It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
clocks, so add a new sun7i-a20-mmc compatible and do not try to use
sample clocks on sun4i / sun5i.

Since sun4i / sun5i do not have sample clocks, they cannot (reliably) do
DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.

Note this patch leaves the clk_prepare_enable() / clk_disable_unprepare()
calls to the sample clks as-is, without adding checks for them being
NULL. All the clk_foo calls accept a NULL clk and will return success when
called with a NULL clk.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a new sun7i-a20-compatible for SoCs with sample clks, rather then
 making them optional
---
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |  6 +++-
 drivers/mmc/host/sunxi-mmc.c                       | 35 +++++++++++++++-------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 4bf41d8..904ff9f 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -8,7 +8,11 @@ as the speed of SD standard 3.0.
 Absolute maximum transfer rate is 200MB/s
 
 Required properties:
- - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mmc"
+ - compatible : should be one of:
+   * "allwinner,sun4i-a10-mmc"
+   * "allwinner,sun5i-a13-mmc"
+   * "allwinner,sun7i-a20-mmc"
+   * "allwinner,sun9i-a80-mmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b631b5c..dcc208c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -662,6 +662,9 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 {
 	int index;
 
+	if (!host->cfg->clk_delays)
+		return 0;
+
 	/* determine delays */
 	if (rate <= 400000) {
 		index = SDXC_CLK_400K;
@@ -978,11 +981,16 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 
 static const struct sunxi_mmc_cfg sun4i_a10_cfg = {
 	.idma_des_size_bits = 13,
-	.clk_delays = sunxi_mmc_clk_delays,
+	.clk_delays = NULL,
 };
 
 static const struct sunxi_mmc_cfg sun5i_a13_cfg = {
 	.idma_des_size_bits = 16,
+	.clk_delays = NULL,
+};
+
+static const struct sunxi_mmc_cfg sun7i_a20_cfg = {
+	.idma_des_size_bits = 16,
 	.clk_delays = sunxi_mmc_clk_delays,
 };
 
@@ -994,6 +1002,7 @@ static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
+	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ /* sentinel */ }
 };
@@ -1032,16 +1041,18 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return PTR_ERR(host->clk_mmc);
 	}
 
-	host->clk_output = devm_clk_get(&pdev->dev, "output");
-	if (IS_ERR(host->clk_output)) {
-		dev_err(&pdev->dev, "Could not get output clock\n");
-		return PTR_ERR(host->clk_output);
-	}
+	if (host->cfg->clk_delays) {
+		host->clk_output = devm_clk_get(&pdev->dev, "output");
+		if (IS_ERR(host->clk_output)) {
+			dev_err(&pdev->dev, "Could not get output clock\n");
+			return PTR_ERR(host->clk_output);
+		}
 
-	host->clk_sample = devm_clk_get(&pdev->dev, "sample");
-	if (IS_ERR(host->clk_sample)) {
-		dev_err(&pdev->dev, "Could not get sample clock\n");
-		return PTR_ERR(host->clk_sample);
+		host->clk_sample = devm_clk_get(&pdev->dev, "sample");
+		if (IS_ERR(host->clk_sample)) {
+			dev_err(&pdev->dev, "Could not get sample clock\n");
+			return PTR_ERR(host->clk_sample);
+		}
 	}
 
 	host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
@@ -1144,9 +1155,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->f_min		=   400000;
 	mmc->f_max		= 52000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				  MMC_CAP_1_8V_DDR |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
+	if (host->cfg->clk_delays)
+		mmc->caps      |= MMC_CAP_1_8V_DDR;
+
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto error_free_dma;
-- 
2.7.4

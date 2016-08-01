From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
Date: Mon, 1 Aug 2016 15:10:29 +0200
Message-ID: <E1bUDND-0000pR-65@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: linux-sunxi@googlegroups.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
a 'New Timings' mode.
Set this capacity in the DT and use it when possible.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
I don't know if this mode works or is needed at 25MHz.
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  1 +
 drivers/mmc/host/sunxi-mmc.c                        | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 4bf41d8..a541bf4 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -19,6 +19,7 @@ Optional properties:
  - reset-names : must contain "ahb"
  - for cd, bus-width and additional generic mmc parameters
    please refer to mmc.txt within this directory
+ - allwinner,new-timings: the controller may accept the "New Timings" mode
 
 Examples:
 	- Within .dtsi:
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 2ee4c21..98922b5 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -64,6 +64,7 @@
 #define SDXC_REG_CBCR	(0x48) /* SMC CIU Byte Count Register */
 #define SDXC_REG_BBCR	(0x4C) /* SMC BIU Byte Count Register */
 #define SDXC_REG_DBGC	(0x50) /* SMC Debug Enable Register */
+#define SDXC_REG_NTSR	(0x5c) /* SMC NewTiming Set Register */
 #define SDXC_REG_HWRST	(0x78) /* SMC Card Hardware Reset for Register */
 #define SDXC_REG_DMAC	(0x80) /* SMC IDMAC Control Register */
 #define SDXC_REG_DLBA	(0x84) /* SMC IDMAC Descriptor List Base Addre */
@@ -171,6 +172,9 @@
 #define SDXC_SEND_AUTO_STOPCCSD		BIT(9)
 #define SDXC_CEATA_DEV_IRQ_ENABLE	BIT(10)
 
+/* NewTiming Set Register */
+#define SDXC_NEWMODE_ENABLE		BIT(31)
+
 /* IDMA controller bus mod bit field */
 #define SDXC_IDMAC_SOFT_RESET		BIT(0)
 #define SDXC_IDMAC_FIX_BURST		BIT(1)
@@ -261,6 +265,9 @@ struct sunxi_mmc_host {
 
 	/* vqmmc */
 	bool		vqmmc_enabled;
+
+	/* misc */
+	bool		new_timings;	/* new timings capable */
 };
 
 static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
@@ -715,8 +722,13 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		return -EINVAL;
 	}
 
-	clk_set_phase(host->clk_sample, sclk_dly);
-	clk_set_phase(host->clk_output, oclk_dly);
+	if (host->new_timings && rate >= 50000000) {
+		mmc_writel(host, REG_NTSR,
+			mmc_readl(host, REG_NTSR) | SDXC_NEWMODE_ENABLE);
+	} else {
+		clk_set_phase(host->clk_sample, sclk_dly);
+		clk_set_phase(host->clk_output, oclk_dly);
+	}
 
 	return sunxi_mmc_oclk_onoff(host, 1);
 }
@@ -1133,12 +1145,17 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_dma;
 
+	if (pdev->dev.of_node &&
+	    of_property_read_bool(pdev->dev.of_node, "allwinner,new-timings"))
+		host->new_timings = true;
+
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto error_free_dma;
 
 	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
 	platform_set_drvdata(pdev, mmc);
+
 	return 0;
 
 error_free_dma:
-- 
2.9.2

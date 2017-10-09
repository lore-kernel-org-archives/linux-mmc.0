From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 02/13] mmc: mediatek: add support of mt2701/mt2712
Date: Mon, 9 Oct 2017 19:35:15 +0800
Message-ID: <1507548926-9555-3-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

mt2701/mt2712 has 12bit clock div, which is not compatible with
mt8135/mt8173. and, some additional features will be added in
mt2701/mt2712, so that need distinguish it by comatibale name.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 82 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 267f7ab..643c795 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -95,6 +95,9 @@
 #define MSDC_CFG_CKDIV          (0xff << 8)	/* RW */
 #define MSDC_CFG_CKMOD          (0x3 << 16)	/* RW */
 #define MSDC_CFG_HS400_CK_MODE  (0x1 << 18)	/* RW */
+#define MSDC_CFG_HS400_CK_MODE_EXTRA  (0x1 << 22)	/* RW */
+#define MSDC_CFG_CKDIV_EXTRA    (0xfff << 8)	/* RW */
+#define MSDC_CFG_CKMOD_EXTRA    (0x3 << 20)	/* RW */
 
 /* MSDC_IOCON mask */
 #define MSDC_IOCON_SDR104CKS    (0x1 << 0)	/* RW */
@@ -295,6 +298,10 @@ struct msdc_save_para {
 	u32 emmc50_cfg0;
 };
 
+struct mtk_mmc_compatible {
+	u8 clk_div_bits;
+};
+
 struct msdc_tune_para {
 	u32 iocon;
 	u32 pad_tune;
@@ -309,6 +316,7 @@ struct msdc_delay_phase {
 
 struct msdc_host {
 	struct device *dev;
+	const struct mtk_mmc_compatible *dev_comp;
 	struct mmc_host *mmc;	/* mmc structure */
 	int cmd_rsp;
 
@@ -350,6 +358,31 @@ struct msdc_host {
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
 };
 
+static const struct mtk_mmc_compatible mt8135_compat = {
+	.clk_div_bits = 8,
+};
+
+static const struct mtk_mmc_compatible mt8173_compat = {
+	.clk_div_bits = 8,
+};
+
+static const struct mtk_mmc_compatible mt2701_compat = {
+	.clk_div_bits = 12,
+};
+
+static const struct mtk_mmc_compatible mt2712_compat = {
+	.clk_div_bits = 12,
+};
+
+static const struct of_device_id msdc_of_ids[] = {
+	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
+	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
+	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
+	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
+	{}
+};
+MODULE_DEVICE_TABLE(of, msdc_of_ids);
+
 static void sdr_set_bits(void __iomem *reg, u32 bs)
 {
 	u32 val = readl(reg);
@@ -509,7 +542,12 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
 		timeout = (ns + clk_ns - 1) / clk_ns + clks;
 		/* in 1048576 sclk cycle unit */
 		timeout = (timeout + (0x1 << 20) - 1) >> 20;
-		sdr_get_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD, &mode);
+		if (host->dev_comp->clk_div_bits == 8)
+			sdr_get_field(host->base + MSDC_CFG,
+				      MSDC_CFG_CKMOD, &mode);
+		else
+			sdr_get_field(host->base + MSDC_CFG,
+				      MSDC_CFG_CKMOD_EXTRA, &mode);
 		/*DDR mode will double the clk cycles for data timeout */
 		timeout = mode >= 2 ? timeout * 2 : timeout;
 		timeout = timeout > 1 ? timeout - 1 : 0;
@@ -548,7 +586,11 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 
 	flags = readl(host->base + MSDC_INTEN);
 	sdr_clr_bits(host->base + MSDC_INTEN, flags);
-	sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
+	if (host->dev_comp->clk_div_bits == 8)
+		sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
+	else
+		sdr_clr_bits(host->base + MSDC_CFG,
+			     MSDC_CFG_HS400_CK_MODE_EXTRA);
 	if (timing == MMC_TIMING_UHS_DDR50 ||
 	    timing == MMC_TIMING_MMC_DDR52 ||
 	    timing == MMC_TIMING_MMC_HS400) {
@@ -568,8 +610,12 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 
 		if (timing == MMC_TIMING_MMC_HS400 &&
 		    hz >= (host->src_clk_freq >> 1)) {
-			sdr_set_bits(host->base + MSDC_CFG,
-				     MSDC_CFG_HS400_CK_MODE);
+			if (host->dev_comp->clk_div_bits == 8)
+				sdr_set_bits(host->base + MSDC_CFG,
+					     MSDC_CFG_HS400_CK_MODE);
+			else
+				sdr_set_bits(host->base + MSDC_CFG,
+					     MSDC_CFG_HS400_CK_MODE_EXTRA);
 			sclk = host->src_clk_freq >> 1;
 			div = 0; /* div is ignore when bit18 is set */
 		}
@@ -587,8 +633,15 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 			sclk = (host->src_clk_freq >> 2) / div;
 		}
 	}
-	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
-		      (mode << 8) | div);
+	if (host->dev_comp->clk_div_bits == 8)
+		sdr_set_field(host->base + MSDC_CFG,
+			      MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
+			      (mode << 8) | div);
+	else
+		sdr_set_field(host->base + MSDC_CFG,
+			      MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
+			      (mode << 12) | div);
+
 	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
@@ -1617,12 +1670,17 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct msdc_host *host;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	int ret;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "No DT found\n");
 		return -EINVAL;
 	}
+
+	of_id = of_match_node(msdc_of_ids, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
 	/* Allocate MMC host for this device */
 	mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
 	if (!mmc)
@@ -1686,11 +1744,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;
+	host->dev_comp = of_id->data;
 	host->mmc = mmc;
 	host->src_clk_freq = clk_get_rate(host->src_clk);
 	/* Set host parameters to mmc */
 	mmc->ops = &mt_msdc_ops;
-	mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 255);
+	if (host->dev_comp->clk_div_bits == 8)
+		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 255);
+	else
+		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
 
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
@@ -1839,12 +1901,6 @@ static int msdc_runtime_resume(struct device *dev)
 	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
 };
 
-static const struct of_device_id msdc_of_ids[] = {
-	{   .compatible = "mediatek,mt8135-mmc", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, msdc_of_ids);
-
 static struct platform_driver mt_msdc_driver = {
 	.probe = msdc_drv_probe,
 	.remove = msdc_drv_remove,
-- 
1.8.1.1.dirty

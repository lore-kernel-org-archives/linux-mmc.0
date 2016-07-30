From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/5] mmc: sunxi: Introduce a sunxi_mmc_cfg struct
Date: Sat, 30 Jul 2016 16:25:45 +0200
Message-ID: <1469888748-26085-3-git-send-email-hdegoede@redhat.com>
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

Create a struct to hold the various model / compatible string dependend
settings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-New patch in v2 of this patch-set
---
 drivers/mmc/host/sunxi-mmc.c | 77 ++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 71a480b..9f44c83 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -229,9 +229,15 @@ struct sunxi_idma_des {
 	u32	buf_addr_ptr2;
 };
 
+struct sunxi_mmc_cfg {
+	u32 idma_des_size_bits;
+	const struct sunxi_mmc_clk_delay *clk_delays;
+};
+
 struct sunxi_mmc_host {
 	struct mmc_host	*mmc;
 	struct reset_control *reset;
+	const struct sunxi_mmc_cfg *cfg;
 
 	/* IO mapping base */
 	void __iomem	*reg_base;
@@ -241,7 +247,6 @@ struct sunxi_mmc_host {
 	struct clk	*clk_mmc;
 	struct clk	*clk_sample;
 	struct clk	*clk_output;
-	const struct sunxi_mmc_clk_delay *clk_delays;
 
 	/* irq */
 	spinlock_t	lock;
@@ -250,7 +255,6 @@ struct sunxi_mmc_host {
 	u32		sdio_imask;
 
 	/* dma */
-	u32		idma_des_size_bits;
 	dma_addr_t	sg_dma;
 	void		*sg_cpu;
 	bool		wait_dma;
@@ -322,7 +326,7 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 {
 	struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
 	dma_addr_t next_desc = host->sg_dma;
-	int i, max_len = (1 << host->idma_des_size_bits);
+	int i, max_len = (1 << host->cfg->idma_des_size_bits);
 
 	for (i = 0; i < data->sg_len; i++) {
 		pdes[i].config = SDXC_IDMAC_DES0_CH | SDXC_IDMAC_DES0_OWN |
@@ -656,6 +660,7 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
+	const struct sunxi_mmc_clk_delay *clk_delays = host->cfg->clk_delays;
 	u32 rate, oclk_dly, rval, sclk_dly;
 	u32 clock = ios->clock;
 	int ret;
@@ -694,22 +699,22 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 
 	/* determine delays */
 	if (rate <= 400000) {
-		oclk_dly = host->clk_delays[SDXC_CLK_400K].output;
-		sclk_dly = host->clk_delays[SDXC_CLK_400K].sample;
+		oclk_dly = clk_delays[SDXC_CLK_400K].output;
+		sclk_dly = clk_delays[SDXC_CLK_400K].sample;
 	} else if (rate <= 25000000) {
-		oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
-		sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
+		oclk_dly = clk_delays[SDXC_CLK_25M].output;
+		sclk_dly = clk_delays[SDXC_CLK_25M].sample;
 	} else if (rate <= 52000000) {
 		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
 		    ios->timing != MMC_TIMING_MMC_DDR52) {
-			oclk_dly = host->clk_delays[SDXC_CLK_50M].output;
-			sclk_dly = host->clk_delays[SDXC_CLK_50M].sample;
+			oclk_dly = clk_delays[SDXC_CLK_50M].output;
+			sclk_dly = clk_delays[SDXC_CLK_50M].sample;
 		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
-			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].output;
-			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].sample;
+			oclk_dly = clk_delays[SDXC_CLK_50M_DDR_8BIT].output;
+			sclk_dly = clk_delays[SDXC_CLK_50M_DDR_8BIT].sample;
 		} else {
-			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
-			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
+			oclk_dly = clk_delays[SDXC_CLK_50M_DDR].output;
+			sclk_dly = clk_delays[SDXC_CLK_50M_DDR].sample;
 		}
 	} else {
 		return -EINVAL;
@@ -938,14 +943,6 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
 	return !!(mmc_readl(host, REG_STAS) & SDXC_CARD_DATA_BUSY);
 }
 
-static const struct of_device_id sunxi_mmc_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-mmc", },
-	{ .compatible = "allwinner,sun5i-a13-mmc", },
-	{ .compatible = "allwinner,sun9i-a80-mmc", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-
 static struct mmc_host_ops sunxi_mmc_ops = {
 	.request	 = sunxi_mmc_request,
 	.set_ios	 = sunxi_mmc_set_ios,
@@ -974,21 +971,37 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  72, .sample =  72 },
 };
 
+static const struct sunxi_mmc_cfg sun4i_a10_cfg = {
+	.idma_des_size_bits = 13,
+	.clk_delays = sunxi_mmc_clk_delays,
+};
+
+static const struct sunxi_mmc_cfg sun5i_a13_cfg = {
+	.idma_des_size_bits = 16,
+	.clk_delays = sunxi_mmc_clk_delays,
+};
+
+static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
+	.idma_des_size_bits = 16,
+	.clk_delays = sun9i_mmc_clk_delays,
+};
+
+static const struct of_device_id sunxi_mmc_of_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
+	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
+	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
+
 static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 				      struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-mmc"))
-		host->idma_des_size_bits = 13;
-	else
-		host->idma_des_size_bits = 16;
-
-	if (of_device_is_compatible(np, "allwinner,sun9i-a80-mmc"))
-		host->clk_delays = sun9i_mmc_clk_delays;
-	else
-		host->clk_delays = sunxi_mmc_clk_delays;
+	host->cfg = of_device_get_match_data(&pdev->dev);
+	if (!host->cfg)
+		return -EINVAL;
 
 	ret = mmc_regulator_get_supply(host->mmc);
 	if (ret) {
@@ -1120,7 +1133,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->max_blk_count	= 8192;
 	mmc->max_blk_size	= 4096;
 	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
-	mmc->max_seg_size	= (1 << host->idma_des_size_bits);
+	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits);
 	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
 	/* 400kHz ~ 52MHz */
 	mmc->f_min		=   400000;
-- 
2.7.4

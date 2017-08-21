From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 08/16] mmc: meson-gx: rework clock init function
Date: Mon, 21 Aug 2017 18:02:53 +0200
Message-ID: <20170821160301.21899-9-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Perform basic initialisation of the clk register before providing it to
the CCF.

Thanks to devm, carrying the clock structure around after init is not
necessary. Rework the function to remove these from the controller host
data.

Finally, set initial mmc clock rate before enabling it, simplifying the
exit condition.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 107 +++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8f9ba5190c18..2f45daa5d510 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -42,10 +42,7 @@
 
 #define SD_EMMC_CLOCK 0x0
 #define   CLK_DIV_MASK GENMASK(5, 0)
-#define   CLK_DIV_MAX 63
 #define   CLK_SRC_MASK GENMASK(7, 6)
-#define   CLK_SRC_XTAL 0   /* external crystal */
-#define   CLK_SRC_PLL 1    /* FCLK_DIV2 */
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
 #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
@@ -137,13 +134,9 @@ struct meson_host {
 	spinlock_t lock;
 	void __iomem *regs;
 	struct clk *core_clk;
-	struct clk_mux mux;
-	struct clk *mux_clk;
+	struct clk *mmc_clk;
 	unsigned long req_rate;
 
-	struct clk_divider cfg_div;
-	struct clk *cfg_div_clk;
-
 	unsigned int bounce_buf_size;
 	void *bounce_buf;
 	dma_addr_t bounce_dma_addr;
@@ -291,7 +284,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 		return 0;
 	}
 
-	ret = clk_set_rate(host->cfg_div_clk, clk_rate);
+	ret = clk_set_rate(host->mmc_clk, clk_rate);
 	if (ret) {
 		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
 			clk_rate, ret);
@@ -299,7 +292,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 	}
 
 	host->req_rate = clk_rate;
-	mmc->actual_clock = clk_get_rate(host->cfg_div_clk);
+	mmc->actual_clock = clk_get_rate(host->mmc_clk);
 
 	dev_dbg(host->dev, "clk rate: %u Hz\n", mmc->actual_clock);
 	if (clk_rate != mmc->actual_clock)
@@ -321,10 +314,13 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 static int meson_mmc_clk_init(struct meson_host *host)
 {
 	struct clk_init_data init;
+	struct clk_mux *mux;
+	struct clk_divider *div;
+	struct clk *clk;
 	char clk_name[32];
 	int i, ret = 0;
 	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
-	const char *clk_div_parents[1];
+	const char *clk_parent[1];
 	u32 clk_reg;
 
 	/* get the mux parents */
@@ -343,66 +339,67 @@ static int meson_mmc_clk_init(struct meson_host *host)
 		mux_parent_names[i] = __clk_get_name(clk);
 	}
 
+	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
+	clk_reg = 0;
+	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
+	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
+	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
+	clk_reg |= CLK_DIV_MASK;
+	clk_reg |= CLK_ALWAYS_ON;
+	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
+
 	/* create the mux */
+	mux = devm_kzalloc(host->dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
 	snprintf(clk_name, sizeof(clk_name), "%s#mux", dev_name(host->dev));
 	init.name = clk_name;
 	init.ops = &clk_mux_ops;
 	init.flags = 0;
 	init.parent_names = mux_parent_names;
 	init.num_parents = MUX_CLK_NUM_PARENTS;
-	host->mux.reg = host->regs + SD_EMMC_CLOCK;
-	host->mux.shift = __bf_shf(CLK_SRC_MASK);
-	host->mux.mask = CLK_SRC_MASK >> host->mux.shift;
-	host->mux.flags = 0;
-	host->mux.table = NULL;
-	host->mux.hw.init = &init;
 
-	host->mux_clk = devm_clk_register(host->dev, &host->mux.hw);
-	if (WARN_ON(IS_ERR(host->mux_clk)))
-		return PTR_ERR(host->mux_clk);
+	mux->reg = host->regs + SD_EMMC_CLOCK;
+	mux->shift = __bf_shf(CLK_SRC_MASK);
+	mux->mask = CLK_SRC_MASK >> mux->shift;
+	mux->hw.init = &init;
+
+	clk = devm_clk_register(host->dev, &mux->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
 
 	/* create the divider */
+	div = devm_kzalloc(host->dev, sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return -ENOMEM;
+
 	snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
 	init.name = clk_name;
 	init.ops = &clk_divider_ops;
 	init.flags = CLK_SET_RATE_PARENT;
-	clk_div_parents[0] = __clk_get_name(host->mux_clk);
-	init.parent_names = clk_div_parents;
-	init.num_parents = ARRAY_SIZE(clk_div_parents);
+	clk_parent[0] = __clk_get_name(clk);
+	init.parent_names = clk_parent;
+	init.num_parents = 1;
 
-	host->cfg_div.reg = host->regs + SD_EMMC_CLOCK;
-	host->cfg_div.shift = __bf_shf(CLK_DIV_MASK);
-	host->cfg_div.width = __builtin_popcountl(CLK_DIV_MASK);
-	host->cfg_div.hw.init = &init;
-	host->cfg_div.flags = CLK_DIVIDER_ONE_BASED |
-		CLK_DIVIDER_ROUND_CLOSEST;
+	div->reg = host->regs + SD_EMMC_CLOCK;
+	div->shift = __bf_shf(CLK_DIV_MASK);
+	div->width = __builtin_popcountl(CLK_DIV_MASK);
+	div->hw.init = &init;
+	div->flags = (CLK_DIVIDER_ONE_BASED |
+		      CLK_DIVIDER_ROUND_CLOSEST);
 
-	host->cfg_div_clk = devm_clk_register(host->dev, &host->cfg_div.hw);
-	if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
-		return PTR_ERR(host->cfg_div_clk);
+	host->mmc_clk = devm_clk_register(host->dev, &div->hw);
+	if (WARN_ON(PTR_ERR_OR_ZERO(host->mmc_clk)))
+		return PTR_ERR(host->mmc_clk);
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
-	clk_reg = 0;
-	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
-	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
-	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
-	clk_reg |= FIELD_PREP(CLK_SRC_MASK, CLK_SRC_XTAL);
-	clk_reg |= FIELD_PREP(CLK_DIV_MASK, CLK_DIV_MAX);
-	clk_reg &= ~CLK_ALWAYS_ON;
-	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
-
-	ret = clk_prepare_enable(host->cfg_div_clk);
+	host->mmc->f_min = clk_round_rate(host->mmc_clk, 400000);
+	ret = clk_set_rate(host->mmc_clk, host->mmc->f_min);
 	if (ret)
 		return ret;
 
-	/* Get the nearest minimum clock to 400KHz */
-	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
-
-	ret = meson_mmc_clk_set(host, host->mmc->f_min);
-	if (ret)
-		clk_disable_unprepare(host->cfg_div_clk);
-
-	return ret;
+	return clk_prepare_enable(host->mmc_clk);
 }
 
 static void meson_mmc_set_tuning_params(struct mmc_host *mmc)
@@ -951,7 +948,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 					meson_mmc_irq_thread, IRQF_SHARED,
 					NULL, host);
 	if (ret)
-		goto err_div_clk;
+		goto err_init_clk;
 
 	mmc->caps |= MMC_CAP_CMD23;
 	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
@@ -967,7 +964,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (host->bounce_buf == NULL) {
 		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
 		ret = -ENOMEM;
-		goto err_div_clk;
+		goto err_init_clk;
 	}
 
 	host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
@@ -986,8 +983,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 err_bounce_buf:
 	dma_free_coherent(host->dev, host->bounce_buf_size,
 			  host->bounce_buf, host->bounce_dma_addr);
-err_div_clk:
-	clk_disable_unprepare(host->cfg_div_clk);
+err_init_clk:
+	clk_disable_unprepare(host->mmc_clk);
 err_core_clk:
 	clk_disable_unprepare(host->core_clk);
 free_host:
@@ -1009,7 +1006,7 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	dma_free_coherent(host->dev, host->bounce_buf_size,
 			  host->bounce_buf, host->bounce_dma_addr);
 
-	clk_disable_unprepare(host->cfg_div_clk);
+	clk_disable_unprepare(host->mmc_clk);
 	clk_disable_unprepare(host->core_clk);
 
 	mmc_free_host(host->mmc);
-- 
2.9.5

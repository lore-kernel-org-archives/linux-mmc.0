From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 02/13] mmc: meson-gx: cfg init overwrite values
Date: Mon, 28 Aug 2017 16:29:04 +0200
Message-ID: <20170828142915.27020-3-jbrunet@baylibre.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828142915.27020-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

cfg init function overwrite values set in the clk init function
Remove the cfg pokes from the clk init. Actually, trying to use
the CLK_AUTO, like initially tried in clk_init, would break
the card initialization

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d2de5c11cdce..7d14d382cb1c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -337,7 +337,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	int i, ret = 0;
 	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
 	const char *clk_div_parents[1];
-	u32 clk_reg, cfg;
+	u32 clk_reg;
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = 0;
@@ -402,12 +402,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
 		return PTR_ERR(host->cfg_div_clk);
 
-	/* Ensure clock starts in "auto" mode, not "always on" */
-	cfg = readl(host->regs + SD_EMMC_CFG);
-	cfg &= ~CFG_CLK_ALWAYS_ON;
-	cfg |= CFG_AUTO_CLK;
-	writel(cfg, host->regs + SD_EMMC_CFG);
-
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret)
 		return ret;
@@ -956,6 +950,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_clk;
 
+	/* set config to sane default */
+	meson_mmc_cfg_init(host);
+
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
@@ -964,9 +961,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
 
-	/* set config to sane default */
-	meson_mmc_cfg_init(host);
-
 	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
 					meson_mmc_irq_thread, IRQF_SHARED,
 					NULL, host);
-- 
2.9.5

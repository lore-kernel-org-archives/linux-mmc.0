From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 05/16] mmc: meson-gx: cfg init overwrite values
Date: Mon, 21 Aug 2017 18:02:50 +0200
Message-ID: <20170821160301.21899-6-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

cfg init function overwrite values set in the clk init function
Remove the cfg pokes from the clk init. Actually, trying to use
the CLK_AUTO, like initially tried in clk_init, would break
the card initialization

BEWARE not to poke the cfg register while the divider value in clk
register is 0. It crashes the SoC.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index a399fbd415f4..61668891b4fc 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -337,7 +337,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	int i, ret = 0;
 	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
 	const char *clk_div_parents[1];
-	u32 clk_reg, cfg;
+	u32 clk_reg;
 
 	/* get the mux parents */
 	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
@@ -403,12 +403,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	clk_reg &= ~CLK_ALWAYS_ON;
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
 
-	/* Ensure clock starts in "auto" mode, not "always on" */
-	cfg = readl(host->regs + SD_EMMC_CFG);
-	cfg &= ~CFG_CLK_ALWAYS_ON;
-	cfg |= CFG_AUTO_CLK;
-	writel(cfg, host->regs + SD_EMMC_CFG);
-
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret)
 		return ret;
@@ -958,6 +952,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_clk;
 
+	/* set config to sane default */
+	meson_mmc_cfg_init(host);
+
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
@@ -966,9 +963,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
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

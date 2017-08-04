From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 13/14] mmc: meson-gx: work around clk-stop issue
Date: Fri,  4 Aug 2017 19:43:52 +0200
Message-ID: <20170804174353.16486-14-jbrunet@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804174353.16486-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

It seems that the signal clock is also used and required, somehow, by
the controller it self.

It is shown during init, when writing to CFG while the divider is set
to 0 will crash the SoC. During voltage switch, the controller may crash
and the card may then fail to exit busy state if the clock is stopped.

To avoid this, it is best to keep the clock running for the controller,
except during rate change. However, we still need to be able to gate
the clock out of the SoC. Let's use the pinmux for this, and fallback
to gpio mode (pulled-down) when we need to gate the clock

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 74 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f973278a3f8d..e991c9e452ab 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -145,6 +145,10 @@ struct meson_host {
 	struct clk *signal_clk;
 	unsigned long req_rate;
 
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_clk_gate;
+
 	unsigned int bounce_buf_size;
 	void *bounce_buf;
 	dma_addr_t bounce_dma_addr;
@@ -308,6 +312,42 @@ static bool meson_mmc_timing_is_ddr(struct mmc_ios *ios)
 	return false;
 }
 
+/*
+ * Gating the clock on this controller is tricky.  It seems the signal clock
+ * is also used by the controller.  It may crash during some operation if the
+ * clock is stopped.  The safest thing to do, whenever possible, is to keep
+ * clock running at stop it at the pad using the pinmux.
+ */
+static void meson_mmc_clk_gate(struct meson_host *host)
+{
+	u32 cfg;
+
+	if (host->pins_clk_gate) {
+		pinctrl_select_state(host->pinctrl, host->pins_clk_gate);
+	} else {
+		/*
+		 * If the pinmux is not provided - default to the classic and
+		 * unsafe method
+		 */
+		cfg = readl(host->regs + SD_EMMC_CFG);
+		cfg |= CFG_STOP_CLOCK;
+		writel(cfg, host->regs + SD_EMMC_CFG);
+	}
+}
+
+static void meson_mmc_clk_ungate(struct meson_host *host)
+{
+	u32 cfg;
+
+	if (host->pins_clk_gate)
+		pinctrl_select_state(host->pinctrl, host->pins_default);
+
+	/* Make sure the clock is not stopped in the controller */
+	cfg = readl(host->regs + SD_EMMC_CFG);
+	cfg &= ~CFG_STOP_CLOCK;
+	writel(cfg, host->regs + SD_EMMC_CFG);
+}
+
 static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -324,9 +364,7 @@ static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 		return 0;
 
 	/* stop clock */
-	cfg = readl(host->regs + SD_EMMC_CFG);
-	cfg |= CFG_STOP_CLOCK;
-	writel(cfg, host->regs + SD_EMMC_CFG);
+	meson_mmc_clk_gate(host);
 	host->req_rate = 0;
 
 	if (!rate) {
@@ -335,6 +373,11 @@ static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 		return 0;
 	}
 
+	/* Stop the clock during rate change to avoid glitches */
+	cfg = readl(host->regs + SD_EMMC_CFG);
+	cfg |= CFG_STOP_CLOCK;
+	writel(cfg, host->regs + SD_EMMC_CFG);
+
 	ret = clk_set_rate(host->signal_clk, rate);
 	if (ret) {
 		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
@@ -354,9 +397,7 @@ static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 		dev_dbg(host->dev, "requested rate was %u\n", ios->clock);
 
 	/* (re)start clock */
-	cfg = readl(host->regs + SD_EMMC_CFG);
-	cfg &= ~CFG_STOP_CLOCK;
-	writel(cfg, host->regs + SD_EMMC_CFG);
+	meson_mmc_clk_ungate(host);
 
 	return 0;
 }
@@ -1037,6 +1078,27 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
+	host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(host->pinctrl)) {
+		ret = PTR_ERR(host->pinctrl);
+		goto free_host;
+	}
+
+	host->pins_default = pinctrl_lookup_state(host->pinctrl,
+						  PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(host->pins_default)) {
+		ret = PTR_ERR(host->pins_default);
+		goto free_host;
+	}
+
+	host->pins_clk_gate = pinctrl_lookup_state(host->pinctrl,
+					     "clk-gate");
+	if (IS_ERR(host->pins_clk_gate)) {
+		dev_warn(&pdev->dev,
+			 "can't get clk-gate pinctrl, using clk_stop bit\n");
+		host->pins_clk_gate = NULL;
+	}
+
 	host->core_clk = devm_clk_get(&pdev->dev, "core");
 	if (IS_ERR(host->core_clk)) {
 		ret = PTR_ERR(host->core_clk);
-- 
2.9.4

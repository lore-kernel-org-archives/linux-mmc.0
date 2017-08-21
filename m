From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 13/16] mmc: meson-gx: use CCF to handle the clock phases
Date: Mon, 21 Aug 2017 18:02:58 +0200
Message-ID: <20170821160301.21899-14-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Several phases can be controlled on the meson-gx controller, the core, tx
and rx clock phase. The tx and rx uses delays to allow for a more fine
grained setting of the phase. To properly compute the phase using delays,
accessing the clock rate is necessary.

Instead of ad-hoc functions, use the common clock framework to set the
clock phases (and access the clock rate while doing it).

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 217 ++++++++++++++++++++++++++++++++--------
 1 file changed, 176 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 441ebf2b0146..df1ac96bd0db 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -46,10 +46,9 @@
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
 #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
-#define   CLK_PHASE_0 0
-#define   CLK_PHASE_90 1
-#define   CLK_PHASE_180 2
-#define   CLK_PHASE_270 3
+#define   CLK_TX_DELAY_MASK GENMASK(19, 16)
+#define   CLK_RX_DELAY_MASK GENMASK(23, 20)
+#define   CLK_DELAY_STEP_PS 200
 #define   CLK_ALWAYS_ON BIT(24)
 
 #define SD_EMMC_DELAY 0x4
@@ -121,9 +120,9 @@
 #define MUX_CLK_NUM_PARENTS 2
 
 struct meson_tuning_params {
-	u8 core_phase;
-	u8 tx_phase;
-	u8 rx_phase;
+	unsigned int core_phase;
+	unsigned int tx_phase;
+	unsigned int rx_phase;
 };
 
 struct sd_emmc_desc {
@@ -142,6 +141,8 @@ struct meson_host {
 	void __iomem *regs;
 	struct clk *core_clk;
 	struct clk *mmc_clk;
+	struct clk *rx_clk;
+	struct clk *tx_clk;
 	unsigned long req_rate;
 
 	struct pinctrl *pinctrl;
@@ -181,6 +182,90 @@ struct meson_host {
 #define CMD_RESP_MASK GENMASK(31, 1)
 #define CMD_RESP_SRAM BIT(0)
 
+struct meson_mmc_phase {
+	struct clk_hw hw;
+	void __iomem *reg;
+	unsigned long phase_mask;
+	unsigned long delay_mask;
+	unsigned int delay_step_ps;
+};
+
+#define to_meson_mmc_phase(_hw) container_of(_hw, struct meson_mmc_phase, hw)
+
+static int meson_mmc_clk_get_phase(struct clk_hw *hw)
+{
+	struct meson_mmc_phase *mmc = to_meson_mmc_phase(hw);
+	unsigned int phase_num = 1 <<  hweight_long(mmc->phase_mask);
+	unsigned long period_ps, p, d;
+		int degrees;
+	u32 val;
+
+	val = readl(mmc->reg);
+	p = (val & mmc->phase_mask) >> __bf_shf(mmc->phase_mask);
+	degrees = p * 360 / phase_num;
+
+	if (mmc->delay_mask) {
+		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+					 clk_get_rate(hw->clk));
+		d = (val & mmc->delay_mask) >> __bf_shf(mmc->delay_mask);
+		degrees += d * mmc->delay_step_ps * 360 / period_ps;
+		degrees %= 360;
+	}
+
+	return degrees;
+}
+
+static void meson_mmc_apply_phase_delay(struct meson_mmc_phase *mmc,
+					unsigned int phase,
+					unsigned int delay)
+{
+	u32 val;
+
+	val = readl(mmc->reg);
+	val &= ~mmc->phase_mask;
+	val |= phase << __bf_shf(mmc->phase_mask);
+
+	if (mmc->delay_mask) {
+		val &= ~mmc->delay_mask;
+		val |= delay << __bf_shf(mmc->delay_mask);
+	}
+
+	writel(val, mmc->reg);
+}
+
+static int meson_mmc_clk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct meson_mmc_phase *mmc = to_meson_mmc_phase(hw);
+	unsigned int phase_num = 1 <<  hweight_long(mmc->phase_mask);
+	unsigned long period_ps, d = 0, r;
+	uint64_t p;
+
+	p = degrees % 360;
+
+	if (!mmc->delay_mask) {
+		p = DIV_ROUND_CLOSEST_ULL(p, 360 / phase_num);
+	} else {
+		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+					 clk_get_rate(hw->clk));
+
+		/* First compute the phase index (p), the remainder (r) is the
+		 * part we'll try to acheive using the delays (d).
+		 */
+		r = do_div(p, 360 / phase_num);
+		d = DIV_ROUND_CLOSEST(r * period_ps,
+				      360 * mmc->delay_step_ps);
+		d = min(d, mmc->delay_mask >> __bf_shf(mmc->delay_mask));
+	}
+
+	meson_mmc_apply_phase_delay(mmc, p, d);
+	return 0;
+}
+
+static const struct clk_ops meson_mmc_clk_phase_ops = {
+	.get_phase = meson_mmc_clk_get_phase,
+	.set_phase = meson_mmc_clk_set_phase,
+};
+
 static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
 {
 	unsigned int timeout = data->timeout_ns / NSEC_PER_MSEC;
@@ -373,6 +458,13 @@ static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 	return 0;
 }
 
+static void meson_mmc_set_phase_params(struct meson_host *host)
+{
+	clk_set_phase(host->mmc_clk, host->tp.core_phase);
+	clk_set_phase(host->tx_clk, host->tp.tx_phase);
+	clk_set_phase(host->rx_clk, host->tp.rx_phase);
+}
+
 /*
  * The SD/eMMC IP block has an internal mux and divider used for
  * generating the MMC clock.  Use the clock framework to create and
@@ -383,6 +475,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	struct clk_init_data init;
 	struct clk_mux *mux;
 	struct clk_divider *div;
+	struct meson_mmc_phase *core, *tx, *rx;
 	struct clk *clk;
 	char clk_name[32];
 	int i, ret = 0;
@@ -408,9 +501,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = 0;
-	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
-	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
-	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
 	clk_reg |= CLK_DIV_MASK;
 	clk_reg |= CLK_ALWAYS_ON;
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
@@ -456,10 +546,80 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	div->flags = (CLK_DIVIDER_ONE_BASED |
 		      CLK_DIVIDER_ROUND_CLOSEST);
 
-	host->mmc_clk = devm_clk_register(host->dev, &div->hw);
+	clk = devm_clk_register(host->dev, &div->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	/* create the mmc core clock */
+	core = devm_kzalloc(host->dev, sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return -ENOMEM;
+
+	snprintf(clk_name, sizeof(clk_name), "%s#core", dev_name(host->dev));
+	init.name = clk_name;
+	init.ops = &meson_mmc_clk_phase_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	clk_parent[0] = __clk_get_name(clk);
+	init.parent_names = clk_parent;
+	init.num_parents = 1;
+
+	core->reg = host->regs + SD_EMMC_CLOCK;
+	core->phase_mask = CLK_CORE_PHASE_MASK;
+	core->hw.init = &init;
+
+	host->mmc_clk = devm_clk_register(host->dev, &core->hw);
 	if (WARN_ON(PTR_ERR_OR_ZERO(host->mmc_clk)))
 		return PTR_ERR(host->mmc_clk);
 
+	/* create the mmc tx clock */
+	tx = devm_kzalloc(host->dev, sizeof(*tx), GFP_KERNEL);
+	if (!tx)
+		return -ENOMEM;
+
+	snprintf(clk_name, sizeof(clk_name), "%s#tx", dev_name(host->dev));
+	init.name = clk_name;
+	init.ops = &meson_mmc_clk_phase_ops;
+	init.flags = 0;
+	clk_parent[0] = __clk_get_name(host->mmc_clk);
+	init.parent_names = clk_parent;
+	init.num_parents = 1;
+
+	tx->reg = host->regs + SD_EMMC_CLOCK;
+	tx->phase_mask = CLK_TX_PHASE_MASK;
+	tx->delay_mask = CLK_TX_DELAY_MASK;
+	tx->delay_step_ps = CLK_DELAY_STEP_PS;
+	tx->hw.init = &init;
+
+	host->tx_clk = devm_clk_register(host->dev, &tx->hw);
+	if (WARN_ON(PTR_ERR_OR_ZERO(host->tx_clk)))
+		return PTR_ERR(host->tx_clk);
+
+	/* create the mmc rx clock */
+	rx = devm_kzalloc(host->dev, sizeof(*rx), GFP_KERNEL);
+	if (!rx)
+		return -ENOMEM;
+
+	snprintf(clk_name, sizeof(clk_name), "%s#rx", dev_name(host->dev));
+	init.name = clk_name;
+	init.ops = &meson_mmc_clk_phase_ops;
+	init.flags = 0;
+	clk_parent[0] = __clk_get_name(host->mmc_clk);
+	init.parent_names = clk_parent;
+	init.num_parents = 1;
+
+	rx->reg = host->regs + SD_EMMC_CLOCK;
+	rx->phase_mask = CLK_RX_PHASE_MASK;
+	rx->delay_mask = CLK_RX_DELAY_MASK;
+	rx->delay_step_ps = CLK_DELAY_STEP_PS;
+	rx->hw.init = &init;
+
+	host->rx_clk = devm_clk_register(host->dev, &rx->hw);
+	if (WARN_ON(PTR_ERR_OR_ZERO(host->rx_clk)))
+		return PTR_ERR(host->rx_clk);
+
+	/* Set the initial phase parameters */
+	meson_mmc_set_phase_params(host);
+
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	host->mmc->f_min = clk_round_rate(host->mmc_clk, 400000);
 	ret = clk_set_rate(host->mmc_clk, host->mmc->f_min);
@@ -469,31 +629,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	return clk_prepare_enable(host->mmc_clk);
 }
 
-static void meson_mmc_set_tuning_params(struct mmc_host *mmc)
-{
-	struct meson_host *host = mmc_priv(mmc);
-	u32 regval;
-
-	/* stop clock */
-	regval = readl(host->regs + SD_EMMC_CFG);
-	regval |= CFG_STOP_CLOCK;
-	writel(regval, host->regs + SD_EMMC_CFG);
-
-	regval = readl(host->regs + SD_EMMC_CLOCK);
-	regval &= ~CLK_CORE_PHASE_MASK;
-	regval |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
-	regval &= ~CLK_TX_PHASE_MASK;
-	regval |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
-	regval &= ~CLK_RX_PHASE_MASK;
-	regval |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
-	writel(regval, host->regs + SD_EMMC_CLOCK);
-
-	/* start clock */
-	regval = readl(host->regs + SD_EMMC_CFG);
-	regval &= ~CFG_STOP_CLOCK;
-	writel(regval, host->regs + SD_EMMC_CFG);
-}
-
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -863,13 +998,13 @@ static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	dev_info(mmc_dev(mmc), "(re)tuning...\n");
 
-	for (i = CLK_PHASE_0; i <= CLK_PHASE_270; i++) {
+	for (i = 0; i < 360; i += 90) {
 		host->tp.rx_phase = i;
 		/* exclude the active parameter set if retuning */
 		if (!memcmp(&tp_old, &host->tp, sizeof(tp_old)) &&
 		    mmc->doing_retune)
 			continue;
-		meson_mmc_set_tuning_params(mmc);
+		meson_mmc_set_phase_params(host);
 		ret = mmc_send_tuning(mmc, opcode, &cmd_error);
 		if (!ret)
 			break;
@@ -1000,9 +1135,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
-	host->tp.core_phase = CLK_PHASE_180;
-	host->tp.tx_phase = CLK_PHASE_0;
-	host->tp.rx_phase = CLK_PHASE_0;
+	host->tp.core_phase = 180;
+	host->tp.tx_phase = 0;
+	host->tp.rx_phase = 0;
 
 	ret = meson_mmc_clk_init(host);
 	if (ret)
-- 
2.9.5

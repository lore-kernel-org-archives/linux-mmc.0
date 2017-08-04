From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 11/14] mmc: meson-gx: rework tuning function
Date: Fri,  4 Aug 2017 19:43:50 +0200
Message-ID: <20170804174353.16486-12-jbrunet@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804174353.16486-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Rework tuning function of the rx phase, with the addition of rx delay.
This allow a more fine setting of the rx phase, which allows to use
new modes such as SDR50.

Also, use 270 degree Tx phase as it make eMMC DDR52 mode functional on
the libretech-cc, without any regression so far.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 215 ++++++++++++++++++++++++++++++----------
 1 file changed, 160 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 33ab341a8b33..560de8faea50 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -50,6 +50,13 @@
 #define   CLK_PHASE_90 1
 #define   CLK_PHASE_180 2
 #define   CLK_PHASE_270 3
+#define   CLK_PHASE_NUM 4
+#define   CLK_TX_DELAY_MASK GENMASK(19, 16)
+#define   CLK_RX_DELAY_MASK GENMASK(23, 20)
+#define   CLK_DELAY_STEP_PS 200
+#define   CLK_PHASE_STEP 30
+#define   CLK_PHASE_POINT_NUM (360 / CLK_PHASE_STEP)
+#define   CLK_DELAY_MAX 0xf
 #define   CLK_ALWAYS_ON BIT(24)
 
 #define SD_EMMC_DELAY 0x4
@@ -120,12 +127,6 @@
 
 #define MUX_CLK_NUM_PARENTS 2
 
-struct meson_tuning_params {
-	u8 core_phase;
-	u8 tx_phase;
-	u8 rx_phase;
-};
-
 struct sd_emmc_desc {
 	u32 cmd_cfg;
 	u32 cmd_arg;
@@ -150,7 +151,6 @@ struct meson_host {
 	struct sd_emmc_desc *descs;
 	dma_addr_t descs_dma_addr;
 
-	struct meson_tuning_params tp;
 	bool vqmmc_enabled;
 };
 
@@ -269,6 +269,35 @@ static void meson_mmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 			     mmc_get_dma_dir(data));
 }
 
+static void meson_mmc_clk_phase_dflt(struct meson_host *host)
+{
+	u32 val;
+
+	val = readl(host->regs + SD_EMMC_CLOCK);
+	val &= ~(CLK_CORE_PHASE_MASK | CLK_TX_PHASE_MASK | CLK_RX_PHASE_MASK |
+		 CLK_TX_DELAY_MASK | CLK_RX_DELAY_MASK);
+
+	/*
+	 * Set phases : These values are mostly the datasheet recommended ones
+	 * except for the Tx phase. Datasheet recommends 180 but DDR52 mode
+	 * does not work with that value. 270 works just fine, w/o any
+	 * regression on the other modes so far.
+	 *
+	 * At this point, cylcing on the Tx phase in the tuning function does
+	 * not seems necessary. We may add it later on, if some mode high speed
+	 * mode needs different Tx phase.
+	 */
+	val |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
+	val |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_270);
+	val |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
+
+	/* Reset delays */
+	val |= FIELD_PREP(CLK_TX_DELAY_MASK, 0);
+	val |= FIELD_PREP(CLK_RX_DELAY_MASK, 0);
+
+	writel(val, host->regs + SD_EMMC_CLOCK);
+}
+
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -348,9 +377,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = 0;
-	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, host->tp.core_phase);
-	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, host->tp.tx_phase);
-	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, host->tp.rx_phase);
 	clk_reg |= CLK_DIV_MASK;
 	clk_reg |= CLK_ALWAYS_ON;
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
@@ -409,31 +435,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	return clk_prepare_enable(host->signal_clk);
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
@@ -472,6 +473,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				host->vqmmc_enabled = true;
 		}
 
+		meson_mmc_clk_phase_dflt(host);
 		break;
 	}
 
@@ -797,27 +799,134 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void meson_mmc_apply_rx_phase_delay(struct meson_host *host,
+					   unsigned int phase,
+					   unsigned int delay)
+{
+	u32 val;
+
+	val = readl(host->regs + SD_EMMC_CLOCK);
+	val &= ~(CLK_RX_PHASE_MASK | CLK_RX_DELAY_MASK);
+	val |= FIELD_PREP(CLK_RX_PHASE_MASK, phase);
+	val |= FIELD_PREP(CLK_RX_DELAY_MASK, delay);
+	writel(val, host->regs + SD_EMMC_CLOCK);
+}
+
+
+static void meson_mmc_set_rx_phase(struct meson_host *host,
+				   unsigned long period_ps,
+				   unsigned int phase)
+{
+	uint64_t p;
+	unsigned long r, d;
+
+	/*
+	 * First compute the phase index (p), the remainder (r) is the part
+	 * we'll try to acheive using 200 ps delays (d).
+	 */
+	p = (phase % 360);
+	r = do_div(p, (360 / CLK_PHASE_NUM));
+	d = DIV_ROUND_CLOSEST((r * period_ps), (CLK_DELAY_STEP_PS * 360));
+
+	if (d > CLK_DELAY_MAX)
+		d = CLK_DELAY_MAX;
+
+	meson_mmc_apply_rx_phase_delay(host, p, d);
+}
+
+static void meson_mmc_shift_map(unsigned long *map, unsigned long shift)
+{
+	DECLARE_BITMAP(left, CLK_PHASE_POINT_NUM);
+	DECLARE_BITMAP(right, CLK_PHASE_POINT_NUM);
+
+	/*
+	 * shift the bitmap right and reintroduce the dropped bits on the left
+	 * of the bitmap
+	 */
+	bitmap_shift_right(right, map, shift, CLK_PHASE_POINT_NUM);
+	bitmap_shift_left(left, map, CLK_PHASE_POINT_NUM - shift,
+			  CLK_PHASE_POINT_NUM);
+	bitmap_or(map, left, right, CLK_PHASE_POINT_NUM);
+}
+
+static void meson_mmc_find_next_region(unsigned long *map,
+				       unsigned long *start,
+				       unsigned long *stop)
+{
+	*start = find_next_bit(map, CLK_PHASE_POINT_NUM, *start);
+	*stop = find_next_zero_bit(map, CLK_PHASE_POINT_NUM, *start);
+}
+
+static int meson_mmc_find_tuning_point(unsigned long *test)
+{
+	unsigned long shift, stop, offset = 0, start = 0, size = 0;
+
+	/* Get the all good/all bad situation out the way */
+	if (bitmap_full(test, CLK_PHASE_POINT_NUM))
+		return 0; /* All points are good so point 0 will do */
+	else if (bitmap_empty(test, CLK_PHASE_POINT_NUM))
+		return -EINVAL; /* No successful tuning point */
+
+	/*
+	 * Now we know there is a least one region find. Make sure it does
+	 * not wrap by the shifting the bitmap if necessary
+	 */
+	shift = find_first_zero_bit(test, CLK_PHASE_POINT_NUM);
+	if (shift != 0)
+		meson_mmc_shift_map(test, shift);
+
+	while (start < CLK_PHASE_POINT_NUM) {
+		meson_mmc_find_next_region(test, &start, &stop);
+
+		if ((stop - start) > size) {
+			offset = start;
+			size = stop - start;
+		}
+
+		start = stop;
+	}
+
+	/* Get the center point of the region */
+	offset += (size / 2);
+
+	/* Shift the result back */
+	offset = (offset + shift) % CLK_PHASE_POINT_NUM;
+
+	return offset;
+}
+
 static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	struct meson_tuning_params tp_old = host->tp;
-	int ret = -EINVAL, i, cmd_error;
-
-	dev_info(mmc_dev(mmc), "(re)tuning...\n");
-
-	for (i = CLK_PHASE_0; i <= CLK_PHASE_270; i++) {
-		host->tp.rx_phase = i;
-		/* exclude the active parameter set if retuning */
-		if (!memcmp(&tp_old, &host->tp, sizeof(tp_old)) &&
-		    mmc->doing_retune)
-			continue;
-		meson_mmc_set_tuning_params(mmc);
-		ret = mmc_send_tuning(mmc, opcode, &cmd_error);
-		if (!ret)
-			break;
+	int point, cmd_error;
+	unsigned long period_ps;
+	DECLARE_BITMAP(test, CLK_PHASE_POINT_NUM);
+
+	dev_dbg(mmc_dev(mmc), "(re)tuning rx phase/delay...\n");
+	meson_mmc_clk_phase_dflt(host);
+
+	/* Get period */
+	period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+				 clk_get_rate(host->signal_clk));
+
+	/* Explore tuning points */
+	for (point = 0; point < CLK_PHASE_POINT_NUM; point++) {
+		meson_mmc_set_rx_phase(host, period_ps, point * CLK_PHASE_STEP);
+		if (!mmc_send_tuning(mmc, opcode, &cmd_error))
+			set_bit(point, test);
 	}
 
-	return ret;
+	/* Find the optimal tuning point and apply it */
+	point = meson_mmc_find_tuning_point(test);
+	if (point < 0) {
+		dev_warn(mmc_dev(mmc), "phase/delay tuning failed\n");
+		return point;
+	}
+
+	dev_dbg(mmc_dev(mmc), "tuning successful: point %d\n", point);
+	meson_mmc_set_rx_phase(host, period_ps, point * CLK_PHASE_STEP);
+
+	return 0;
 }
 
 /*
@@ -921,10 +1030,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
-	host->tp.core_phase = CLK_PHASE_180;
-	host->tp.tx_phase = CLK_PHASE_0;
-	host->tp.rx_phase = CLK_PHASE_0;
-
 	ret = meson_mmc_clk_init(host);
 	if (ret)
 		goto err_core_clk;
-- 
2.9.4

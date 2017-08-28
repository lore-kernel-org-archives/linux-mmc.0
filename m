From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 13/13] mmc: meson-gx: rework tuning function
Date: Mon, 28 Aug 2017 16:29:15 +0200
Message-ID: <20170828142915.27020-14-jbrunet@baylibre.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828142915.27020-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Rework tuning function of the rx phase. Now that the phase can be
more precisely set using CCF, test more phase setting and find the
largest working window. Then the tuning selected is the one at the
center of the window.

This rework allows to use new modes, such as UHS SDR50

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 161 +++++++++++++++++++++++++++-------------
 1 file changed, 111 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index efffd36c8d77..987bae98c61f 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -49,6 +49,8 @@
 #define   CLK_TX_DELAY_MASK GENMASK(19, 16)
 #define   CLK_RX_DELAY_MASK GENMASK(23, 20)
 #define   CLK_DELAY_STEP_PS 200
+#define   CLK_PHASE_STEP 30
+#define   CLK_PHASE_POINT_NUM (360 / CLK_PHASE_STEP)
 #define   CLK_ALWAYS_ON BIT(24)
 
 #define SD_EMMC_DELAY 0x4
@@ -119,12 +121,6 @@
 
 #define MUX_CLK_NUM_PARENTS 2
 
-struct meson_tuning_params {
-	unsigned int core_phase;
-	unsigned int tx_phase;
-	unsigned int rx_phase;
-};
-
 struct sd_emmc_desc {
 	u32 cmd_cfg;
 	u32 cmd_arg;
@@ -155,7 +151,6 @@ struct meson_host {
 	struct sd_emmc_desc *descs;
 	dma_addr_t descs_dma_addr;
 
-	struct meson_tuning_params tp;
 	bool vqmmc_enabled;
 };
 
@@ -458,13 +453,6 @@ static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 	return 0;
 }
 
-static void meson_mmc_set_phase_params(struct meson_host *host)
-{
-	clk_set_phase(host->mmc_clk, host->tp.core_phase);
-	clk_set_phase(host->tx_clk, host->tp.tx_phase);
-	clk_set_phase(host->rx_clk, host->tp.rx_phase);
-}
-
 /*
  * The SD/eMMC IP block has an internal mux and divider used for
  * generating the MMC clock.  Use the clock framework to create and
@@ -617,18 +605,122 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	if (WARN_ON(PTR_ERR_OR_ZERO(host->rx_clk)))
 		return PTR_ERR(host->rx_clk);
 
-	/* Set the initial phase parameters */
-	meson_mmc_set_phase_params(host);
-
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	host->mmc->f_min = clk_round_rate(host->mmc_clk, 400000);
 	ret = clk_set_rate(host->mmc_clk, host->mmc->f_min);
 	if (ret)
 		return ret;
 
+	/*
+	 * Set phases : These values are mostly the datasheet recommended ones
+	 * except for the Tx phase. Datasheet recommends 180 but some cards
+	 * fail at initialisation with it. 270 works just fine, it fixes these
+	 * initialisation issues and enable eMMC DDR52 mode.
+	 */
+	clk_set_phase(host->mmc_clk, 180);
+	clk_set_phase(host->tx_clk, 270);
+	clk_set_phase(host->rx_clk, 0);
+
 	return clk_prepare_enable(host->mmc_clk);
 }
 
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
+		return -EIO; /* No successful tuning point */
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
+static int meson_mmc_clk_phase_tuning(struct mmc_host *mmc, u32 opcode,
+				      struct clk *clk)
+{
+	int point, ret;
+	DECLARE_BITMAP(test, CLK_PHASE_POINT_NUM);
+
+	dev_dbg(mmc_dev(mmc), "%s phase/delay tunning...\n",
+		__clk_get_name(clk));
+	bitmap_zero(test, CLK_PHASE_POINT_NUM);
+
+	/* Explore tuning points */
+	for (point = 0; point < CLK_PHASE_POINT_NUM; point++) {
+		clk_set_phase(clk, point * CLK_PHASE_STEP);
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret)
+			set_bit(point, test);
+	}
+
+	/* Find the optimal tuning point and apply it */
+	point = meson_mmc_find_tuning_point(test);
+	if (point < 0)
+		return point; /* tuning failed */
+
+	clk_set_phase(clk, point * CLK_PHASE_STEP);
+	dev_dbg(mmc_dev(mmc), "success with phase: %d\n",
+		clk_get_phase(clk));
+	return 0;
+}
+
+static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct meson_host *host = mmc_priv(mmc);
+
+	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
+}
+
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -667,6 +759,8 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				host->vqmmc_enabled = true;
 		}
 
+		/* Reset rx phase */
+		clk_set_phase(host->rx_clk, 0);
 		break;
 	}
 
@@ -989,29 +1083,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
-{
-	struct meson_host *host = mmc_priv(mmc);
-	struct meson_tuning_params tp_old = host->tp;
-	int ret = -EINVAL, i, cmd_error;
-
-	dev_info(mmc_dev(mmc), "(re)tuning...\n");
-
-	for (i = 0; i < 360; i += 90) {
-		host->tp.rx_phase = i;
-		/* exclude the active parameter set if retuning */
-		if (!memcmp(&tp_old, &host->tp, sizeof(tp_old)) &&
-		    mmc->doing_retune)
-			continue;
-		meson_mmc_set_phase_params(host);
-		ret = mmc_send_tuning(mmc, opcode, &cmd_error);
-		if (!ret)
-			break;
-	}
-
-	return ret;
-}
-
 /*
  * NOTE: we only need this until the GPIO/pinctrl driver can handle
  * interrupts.  For now, the MMC core will use this for polling.
@@ -1156,16 +1227,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
-	/*
-	 * Set phases : These values are mostly the datasheet recommended ones
-	 * except for the Tx phase. Datasheet recommends 180 but some cards
-	 * fail at initialisation with it. 270 works just fine, it fixes these
-	 * initialisation issues and enable eMMC DDR52 mode.
-	 */
-	host->tp.core_phase = 180;
-	host->tp.tx_phase = 270;
-	host->tp.rx_phase = 0;
-
 	ret = meson_mmc_clk_init(host);
 	if (ret)
 		goto err_core_clk;
-- 
2.9.5

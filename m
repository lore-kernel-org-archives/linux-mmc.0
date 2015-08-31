From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6/8] mmc: dw_mmc: Generic MMC tuning with the clock phase framework
Date: Mon, 31 Aug 2015 20:24:04 +0200
Message-ID: <1441045446-30858-7-git-send-email-heiko@sntech.de>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1441045446-30858-1-git-send-email-heiko@sntech.de>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>, Heiko Stuebner <heiko@sntech.de>
List-Id: linux-mmc@vger.kernel.org

From: Alexandru M Stan <amstan@chromium.org>

This algorithm will try 1 degree increments, since there's no way to tell
what resolution the underlying phase code uses. As an added bonus, doing
many tunings yields better results since some tests are run more than once
(ex: if the underlying driver uses 45 degree increments, the tuning code
will try the same angle more than once).

It will then construct a list of good phase ranges (even ranges that cross
360/0), will pick the biggest range then it will set the sample_clk to the
middle of that range.

We do not touch ciu_drive (and by extension define default-drive-phase).
Drive phase is mostly used to define minimum hold times, while one could
write some code to determine what phase meets the minimum hold time (ex 10
degrees) this will not work with the current clock phase framework (which
floors angles, so we'll get 0 deg, and there's no way to know what
resolution the floors happen at). We assume that the default drive angles
set by the hardware are good enough.

If a device has device specific code (like exynos) then that will still
take precedence, otherwise this new code will execute. If the device wants
to tune, but has no sample_clk defined we'll return EIO with an error
message.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>

Convert to mmc_send_tuning()
Fold in from the ChromeOS-tree:
 - mmc: dw_mmc: Change tuning to only 16 phases
 - mmc: dw_mmc: Test more phases
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc.c  | 142 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h |   3 +
 2 files changed, 145 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b1b7e7f..13bcde0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1194,6 +1194,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (drv_data && drv_data->set_ios)
 		drv_data->set_ios(slot->host, ios);
 
+	/* Make sure we use phases which we can enumerate with */
+	if (!IS_ERR(slot->host->sample_clk)) {
+		clk_set_phase(slot->host->sample_clk,
+			      slot->host->default_sample_phase);
+	}
+
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc)) {
@@ -1414,6 +1420,127 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
+#define NUM_PHASES			360
+#define TUNING_ITERATION_TO_PHASE(i)	(DIV_ROUND_UP((i) * 360, NUM_PHASES))
+
+static int dw_mci_execute_generic_tuning(struct dw_mci_slot *slot)
+{
+	struct dw_mci *host = slot->host;
+	struct mmc_host *mmc = slot->mmc;
+	int ret = 0;
+	int i;
+	bool v, prev_v = 0, first_v;
+	struct range_t {
+		int start;
+		int end; /* inclusive */
+	};
+	struct range_t *ranges;
+	unsigned int range_count = 0;
+	int longest_range_len = -1;
+	int longest_range = -1;
+	int middle_phase;
+
+	if (IS_ERR(host->sample_clk)) {
+		dev_err(host->dev, "Tuning clock (sample_clk) not defined.\n");
+		return -EIO;
+	}
+
+	ranges = kmalloc_array(NUM_PHASES / 2 + 1, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+
+	/* Try each phase and extract good ranges */
+	for (i = 0; i < NUM_PHASES; ) {
+		clk_set_phase(host->sample_clk, TUNING_ITERATION_TO_PHASE(i));
+
+		v = !mmc_send_tuning(mmc);
+
+		if (i == 0)
+			first_v = v;
+
+		if ((!prev_v) && v) {
+			range_count++;
+			ranges[range_count-1].start = i;
+		}
+		if (v) {
+			ranges[range_count-1].end = i;
+			i++;
+		} else if (i == NUM_PHASES - 1) {
+			/* No extra skipping rules if we're at the end */
+			i++;
+		} else {
+			/*
+			 * No need to check too close to an invalid
+			 * one since testing bad phases is slow.  Skip
+			 * 20 degrees.
+			 */
+			i += DIV_ROUND_UP(20 * NUM_PHASES, 360);
+
+			/* Always test the last one */
+			if (i >= NUM_PHASES)
+				i = NUM_PHASES - 1;
+		}
+
+		prev_v = v;
+	}
+
+	if (range_count == 0) {
+		dev_warn(host->dev, "All phases bad!");
+		ret = -EIO;
+		goto free;
+	}
+
+	/* wrap around case, merge the end points */
+	if ((range_count > 1) && first_v && v) {
+		ranges[0].start = ranges[range_count-1].start;
+		range_count--;
+	}
+
+	if (ranges[0].start == 0 && ranges[0].end == NUM_PHASES - 1) {
+		clk_set_phase(host->sample_clk, host->default_sample_phase);
+		dev_info(host->dev, "All phases work, using default phase %d.",
+			 host->default_sample_phase);
+		goto free;
+	}
+
+	/* Find the longest range */
+	for (i = 0; i < range_count; i++) {
+		int len = (ranges[i].end - ranges[i].start + 1);
+
+		if (len < 0)
+			len += NUM_PHASES;
+
+		if (longest_range_len < len) {
+			longest_range_len = len;
+			longest_range = i;
+		}
+
+		dev_dbg(host->dev, "Good phase range %d-%d (%d len)\n",
+			TUNING_ITERATION_TO_PHASE(ranges[i].start),
+			TUNING_ITERATION_TO_PHASE(ranges[i].end),
+			len
+		);
+	}
+
+	dev_dbg(host->dev, "Best phase range %d-%d (%d len)\n",
+		TUNING_ITERATION_TO_PHASE(ranges[longest_range].start),
+		TUNING_ITERATION_TO_PHASE(ranges[longest_range].end),
+		longest_range_len
+	);
+
+	middle_phase = ranges[longest_range].start + longest_range_len / 2;
+	middle_phase %= NUM_PHASES;
+	dev_info(host->dev, "Successfully tuned phase to %d\n",
+		 TUNING_ITERATION_TO_PHASE(middle_phase));
+
+	clk_set_phase(host->sample_clk,
+		      TUNING_ITERATION_TO_PHASE(middle_phase));
+
+free:
+	kfree(ranges);
+	return ret;
+}
+
 static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -1423,6 +1550,8 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	if (drv_data && drv_data->execute_tuning)
 		err = drv_data->execute_tuning(slot);
+	else
+		err = dw_mci_execute_generic_tuning(slot);
 	return err;
 }
 
@@ -2741,6 +2870,11 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
+	if (of_property_read_u32(np, "default-sample-phase",
+					&host->default_sample_phase)) {
+		host->default_sample_phase = 0;
+	}
+
 	if (drv_data && drv_data->parse_dt) {
 		ret = drv_data->parse_dt(host);
 		if (ret)
@@ -2843,6 +2977,14 @@ int dw_mci_probe(struct dw_mci *host)
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 	}
 
+	host->drv_clk = devm_clk_get(host->dev, "ciu_drv");
+	if (IS_ERR(host->drv_clk))
+		dev_dbg(host->dev, "ciu_drv not available\n");
+
+	host->sample_clk = devm_clk_get(host->dev, "ciu_sample");
+	if (IS_ERR(host->sample_clk))
+		dev_dbg(host->dev, "ciu_sample not available\n");
+
 	if (!host->bus_hz) {
 		dev_err(host->dev,
 			"Platform data must supply bus speed\n");
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 134c574..40187ba 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -176,7 +176,10 @@ struct dw_mci {
 	void			*priv;
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
+	struct clk		*drv_clk;
+	struct clk		*sample_clk;
 	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
+	int			default_sample_phase;
 
 	/* FIFO push and pull */
 	int			fifo_depth;
-- 
2.1.4


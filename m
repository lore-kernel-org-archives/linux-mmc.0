From: Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 2/3] mmc: dw_mmc: Generic MMC tuning with the clock phase framework
Date: Thu, 18 Dec 2014 15:01:02 -0800
Message-ID: <1418943663-10012-3-git-send-email-amstan@chromium.org>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42649 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaLRXBY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 18:01:24 -0500
Received: by mail-ob0-f181.google.com with SMTP id gq1so6945601obb.12
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 15:01:23 -0800 (PST)
In-Reply-To: <1418943663-10012-1-git-send-email-amstan@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com, jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, addy ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Mike Turquette <mturquette@linaro.org>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>

This algorithm will try 5 degree increments, since there's no way to tell
what resolution the underlying phase code uses. As an added bonus, doing many
tunings yields better results since some tests are run more than once(ex: if the
underlying driver uses 45 degree increments, the tuning code will try the same
angle more than once).

It will then construct a list of good phase ranges (even ranges that cross
360/0), will pick the biggest range then it will set the sample_clk to the
middle of that range.

We do not touch ciu_drive (and by extension define default-drive-phase). Drive
phase is mostly used to define minimum hold times, while one could write some
code to determine what phase meets the minimum hold time (ex 10 degrees) this
will not work with the current clock phase framework (which floors angles, so
we'll get 0 deg, and there's no way to know what resolution the floors happen
at). We assume that the default drive angles set by the hardware are good enough.

If a device has device specific code (like exynos) then that will still take
precedence, otherwise this new code will execute. If the device wants to tune,
but has no sample_clk defined we'll return EIO with an error message.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
Suggested-by: Heiko Stuebner <heiko@sntech.de>
Suggested-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c  | 189 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h |   3 +
 2 files changed, 192 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 69f0cc6..b59c221 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -984,6 +984,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (drv_data && drv_data->set_ios)
 		drv_data->set_ios(slot->host, ios);
 
+	/* Make sure we use phases which we can enumerate with */
+	if (!IS_ERR(slot->host->sample_clk)) {
+		clk_set_phase(slot->host->sample_clk,
+			      slot->host->default_sample_phase);
+	}
+
 	/* Slot specific timing and width adjustment */
 	dw_mci_setup_bus(slot, false);
 
@@ -1187,6 +1193,174 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	}
 }
 
+static int dw_mci_tuning_test(struct dw_mci_slot *slot, u32 opcode,
+			       struct dw_mci_tuning_data *tuning_data,
+			       u8 *blk_test)
+{
+	struct dw_mci *host = slot->host;
+	struct mmc_host *mmc = slot->mmc;
+	const u8 *blk_pattern = tuning_data->blk_pattern;
+	unsigned int blksz = tuning_data->blksz;
+	struct mmc_request mrq = { NULL };
+	struct mmc_command cmd = {0};
+	struct mmc_command stop = {0};
+	struct mmc_data data = {0};
+	struct scatterlist sg;
+
+	memset(blk_test, 0, blksz);
+
+	cmd.opcode = opcode;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	stop.opcode = MMC_STOP_TRANSMISSION;
+	stop.arg = 0;
+	stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+	data.blksz = blksz;
+	data.blocks = 1;
+	data.flags = MMC_DATA_READ;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	sg_init_one(&sg, blk_test, blksz);
+	mrq.cmd = &cmd;
+	mrq.stop = &stop;
+	mrq.data = &data;
+	host->mrq = &mrq;
+
+	mci_writel(host, TMOUT, ~0);
+
+	mmc_wait_for_req(mmc, &mrq);
+
+	if (!cmd.error && !data.error) {
+		if (!memcmp(blk_pattern, blk_test, blksz))
+			return 0;
+		return -EIO;
+	} else {
+		dev_dbg(host->dev,
+			"Tuning error: cmd.error:%d, data.error:%d\n",
+			cmd.error, data.error);
+		if (cmd.error)
+			return cmd.error;
+		else
+			return data.error;
+	}
+}
+
+static int dw_mci_execute_generic_tuning(struct dw_mci_slot *slot, u32 opcode,
+					 struct dw_mci_tuning_data *tuning_data)
+{
+	struct dw_mci *host = slot->host;
+	unsigned int blksz = tuning_data->blksz;
+	u8 *blk_test;
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
+	const int PHASE_INCREMENT = 5;
+	const int NUM_PHASES = 360 / PHASE_INCREMENT;
+
+	if (IS_ERR(host->sample_clk)) {
+		dev_err(host->dev, "Tuning clock (sample_clk) not defined.\n");
+		return -EIO;
+	}
+
+	blk_test = kmalloc(blksz, GFP_KERNEL);
+	if (!blk_test)
+		return -ENOMEM;
+
+	ranges = kmalloc(((NUM_PHASES / 2 + 1) * sizeof(ranges)), GFP_KERNEL);
+	if (!blk_test) {
+		ret = -ENOMEM;
+		goto free_blk_test;
+	}
+
+	/* Try each phase and extract good ranges */
+	for (i = 0; i < NUM_PHASES; i++) {
+		clk_set_phase(host->sample_clk, i * PHASE_INCREMENT);
+
+		v = !dw_mci_tuning_test(slot, opcode, tuning_data, blk_test);
+
+		if ((!prev_v) && v) {
+			range_count++;
+			ranges[range_count-1].start = i;
+		}
+		if (v) {
+			ranges[range_count-1].end = i;
+		}
+
+		if (i == 0)
+			first_v = v;
+
+		prev_v = v;
+	}
+
+	if (range_count == 0) {
+		dev_info(host->dev, "All phases bad!");
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
+	if ((ranges[0].start == 0) && (ranges[0].end == NUM_PHASES - 1)) {
+		clk_set_phase(host->sample_clk, host->default_sample_phase);
+		dev_info(host->dev, "All phases work, using default phase %d.",
+			host->default_sample_phase);
+		goto free;
+	}
+
+	/* Find the longest range */
+	for (i = 0; i < range_count; i++) {
+		int len = (ranges[i].end - ranges[i].start + 1);
+		if (len < 0)
+			len += NUM_PHASES;
+
+		if (longest_range_len < len) {
+			longest_range_len = len;
+			longest_range = i;
+		}
+
+		dev_dbg(host->dev, "Good phase range %d-%d (%d len)\n",
+			ranges[i].start * PHASE_INCREMENT,
+			ranges[i].end * PHASE_INCREMENT,
+			len
+		);
+	}
+
+	dev_dbg(host->dev, "Best phase range %d-%d (%d len)\n",
+		ranges[longest_range].start * PHASE_INCREMENT,
+		ranges[longest_range].end * PHASE_INCREMENT,
+		longest_range_len
+	);
+
+	middle_phase = ranges[longest_range].start + longest_range_len / 2;
+	middle_phase %= NUM_PHASES;
+	dev_info(host->dev, "Successfully tuned phase to %d\n",
+		middle_phase * PHASE_INCREMENT);
+
+	clk_set_phase(host->sample_clk, middle_phase * PHASE_INCREMENT);
+
+free:
+	kfree(ranges);
+free_blk_test:
+	kfree(blk_test);
+	return ret;
+}
+
 static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -1216,6 +1390,8 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	if (drv_data && drv_data->execute_tuning)
 		err = drv_data->execute_tuning(slot, opcode, &tuning_data);
+	else
+		err = dw_mci_execute_generic_tuning(slot, opcode, &tuning_data);
 	return err;
 }
 
@@ -2492,6 +2668,11 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
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
@@ -2564,6 +2745,14 @@ int dw_mci_probe(struct dw_mci *host)
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
index 0013669..335e2f3 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -172,7 +172,10 @@ struct dw_mci {
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
2.2.0.rc0.207.ga3a616c


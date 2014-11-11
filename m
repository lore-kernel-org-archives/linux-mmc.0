From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] mmc: sdhci-sirf: add sirf tuning function (cmd 19)
Date: Tue, 11 Nov 2014 23:47:44 +0800
Message-ID: <1415720864-3936-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:41694 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbaKKPuE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Nov 2014 10:50:04 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so10320963pdb.39
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2014 07:50:03 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, chris@printf.net
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Minda Chen <Minda.Chen@csr.com>

Add manual tuning function in CSR atlas7 SoC. It is mainly used
for the UHS-I SD card working SDR50 SDR104 mode.

The tuning principle can be seen in SD spec part1 v3.01 4.2.4.5
(tuning command).

SD host send the cmd19 and set the delay value(0-127).
and the sdcard return 64 bytes data. If the data is same with
the tuning data. The delay value is valid. Execute this commmand
128 times. And calculate the longest window of the valid values.
The value in the middle of this window is the best value.

Signed-off-by: Minda Chen <Minda.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c | 105 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index dd29d47..c71cf4e 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -8,14 +8,18 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/slab.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include "sdhci-pltfm.h"
 
+#define SDHCI_CLK_DELAY_SETTING 0x4C
 #define SDHCI_SIRF_8BITBUS BIT(3)
+#define SIRF_TUNING_COUNT 128
 
 struct sdhci_sirf_priv {
 	struct clk *clk;
@@ -49,7 +53,106 @@ static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
+static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int tuning_seq_cnt = 3;
+	u8 phase, *data_buf, tuned_phases[SIRF_TUNING_COUNT];
+	u8 tuned_phase_cnt = 0;
+	const u8 *tuning_block_pattern = tuning_blk_pattern_4bit;
+	int size = sizeof(tuning_blk_pattern_4bit);
+	int rc, longest_range = 0;
+	int start = -1, end, tuning_value = -1, range = 0;
+	u16 clock_setting;
+	struct mmc_host *mmc = host->mmc;
+
+	data_buf = kmalloc(size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+
+	clock_setting = sdhci_readw(host, SDHCI_CLK_DELAY_SETTING);
+	clock_setting &= ~0x3fff;
+
+retry:
+	phase = 0;
+	do {
+		struct mmc_command cmd = { 0 };
+		struct mmc_data data = { 0 };
+		struct mmc_request mrq = {
+			.cmd = &cmd,
+			.data = &data
+		};
+		struct scatterlist sg;
+
+		sdhci_writel(host,
+			clock_setting | phase | (phase << 7) | (phase << 16),
+			SDHCI_CLK_DELAY_SETTING);
+
+		cmd.opcode = opcode;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+		data.blksz = size;
+		data.blocks = 1;
+		data.flags = MMC_DATA_READ;
+		data.timeout_ns = NSEC_PER_SEC;	/* 1 second */
+
+		data.sg = &sg;
+		data.sg_len = 1;
+		sg_init_one(&sg, data_buf, size);
+		memset(data_buf, 0, size);
+		mmc_wait_for_req(mmc, &mrq);
+
+		if (!cmd.error && !data.error &&
+		    !memcmp(data_buf, tuning_block_pattern, size)) {
+			/* Tuning is successful at this tuning point */
+			tuned_phases[tuned_phase_cnt++] = phase;
+			dev_dbg(mmc_dev(mmc), "%s: Found good phase = %d\n",
+				 mmc_hostname(mmc), phase);
+			if (start == -1)
+				start = phase;
+			end = phase;
+			range++;
+			if (phase == (SIRF_TUNING_COUNT - 1)
+				&& range > longest_range)
+				tuning_value = (start + end) / 2;
+		} else {
+			dev_dbg(mmc_dev(mmc), "%s: Found bad phase = %d\n",
+				 mmc_hostname(mmc), phase);
+			if (range > longest_range) {
+				tuning_value = (start + end) / 2;
+				longest_range = range;
+			}
+			start = -1;
+			end = range = 0;
+		}
+	} while (++phase < ARRAY_SIZE(tuned_phases));
+
+	if (tuned_phase_cnt && tuning_value > 0) {
+		/*
+		 * Finally set the selected phase in delay
+		 * line hw block.
+		 */
+		phase = tuning_value;
+		sdhci_writel(host,
+			clock_setting | phase | (phase << 7) | (phase << 16),
+			SDHCI_CLK_DELAY_SETTING);
+
+		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
+			 mmc_hostname(mmc), phase);
+	} else {
+		if (--tuning_seq_cnt)
+			goto retry;
+		/* Tuning failed */
+		dev_dbg(mmc_dev(mmc), "%s: No tuning point found\n",
+		       mmc_hostname(mmc));
+		rc = -EIO;
+	}
+
+	kfree(data_buf);
+	return rc;
+}
+
 static struct sdhci_ops sdhci_sirf_ops = {
+	.platform_execute_tuning = sdhci_sirf_execute_tuning,
 	.set_clock = sdhci_set_clock,
 	.get_max_clock	= sdhci_sirf_get_max_clk,
 	.set_bus_width = sdhci_sirf_set_bus_width,
-- 
2.1.1


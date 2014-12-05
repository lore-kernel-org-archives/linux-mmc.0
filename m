From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/4] mmc: sdhci-esdhc-imx: Convert to mmc_send_tuning()
Date: Fri,  5 Dec 2014 12:59:40 +0100
Message-ID: <1417780783-12939-2-git-send-email-ulf.hansson@linaro.org>
References: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:45217 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbaLEL7x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Dec 2014 06:59:53 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so519990lab.32
        for <linux-mmc@vger.kernel.org>; Fri, 05 Dec 2014 03:59:51 -0800 (PST)
In-Reply-To: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

Instead of having a local function taking care of sending the tuning
command, let's use the common mmc_send_tuning() API provided by the mmc
core. In this way the request will be handled as any other request by
sdhci core.

As an effect of this change, the pm_runtime_get_sync() call at
esdhc_prepare_tuning() isn't needed any more.

This patch will also introduce another change in behavior, since before
the response pattern to the tuning command wasn't verified by
sdhci-esdhc-imx. The mmc_send_tuning() does that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Rebased, to get latest version of the mmc_send_tuning() API.

---
 drivers/mmc/host/sdhci-esdhc-imx.c | 68 ++------------------------------------
 1 file changed, 3 insertions(+), 65 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 0135f00..12711ab 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -65,8 +65,6 @@
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
 #define ESDHC_TUNING_START_TAP		0x1
 
-#define ESDHC_TUNING_BLOCK_PATTERN_LEN	64
-
 /* pinctrl state */
 #define ESDHC_PINCTRL_STATE_100MHZ	"state_100mhz"
 #define ESDHC_PINCTRL_STATE_200MHZ	"state_200mhz"
@@ -692,8 +690,6 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
 	mdelay(1);
 
-	/* This is balanced by the runtime put in sdhci_tasklet_finish */
-	pm_runtime_get_sync(host->mmc->parent);
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
@@ -704,54 +700,6 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
 }
 
-static void esdhc_request_done(struct mmc_request *mrq)
-{
-	complete(&mrq->completion);
-}
-
-static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode,
-				 struct scatterlist *sg)
-{
-	struct mmc_command cmd = {0};
-	struct mmc_request mrq = {NULL};
-	struct mmc_data data = {0};
-
-	cmd.opcode = opcode;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
-
-	data.blksz = ESDHC_TUNING_BLOCK_PATTERN_LEN;
-	data.blocks = 1;
-	data.flags = MMC_DATA_READ;
-	data.sg = sg;
-	data.sg_len = 1;
-
-	mrq.cmd = &cmd;
-	mrq.cmd->mrq = &mrq;
-	mrq.data = &data;
-	mrq.data->mrq = &mrq;
-	mrq.cmd->data = mrq.data;
-
-	mrq.done = esdhc_request_done;
-	init_completion(&(mrq.completion));
-
-	spin_lock_irq(&host->lock);
-	host->mrq = &mrq;
-
-	sdhci_send_command(host, mrq.cmd);
-
-	spin_unlock_irq(&host->lock);
-
-	wait_for_completion(&mrq.completion);
-
-	if (cmd.error)
-		return cmd.error;
-	if (data.error)
-		return data.error;
-
-	return 0;
-}
-
 static void esdhc_post_tuning(struct sdhci_host *host)
 {
 	u32 reg;
@@ -763,21 +711,13 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 
 static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 {
-	struct scatterlist sg;
-	char *tuning_pattern;
 	int min, max, avg, ret;
 
-	tuning_pattern = kmalloc(ESDHC_TUNING_BLOCK_PATTERN_LEN, GFP_KERNEL);
-	if (!tuning_pattern)
-		return -ENOMEM;
-
-	sg_init_one(&sg, tuning_pattern, ESDHC_TUNING_BLOCK_PATTERN_LEN);
-
 	/* find the mininum delay first which can pass tuning */
 	min = ESDHC_TUNE_CTRL_MIN;
 	while (min < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, min);
-		if (!esdhc_send_tuning_cmd(host, opcode, &sg))
+		if (!mmc_send_tuning(host->mmc))
 			break;
 		min += ESDHC_TUNE_CTRL_STEP;
 	}
@@ -786,7 +726,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	max = min + ESDHC_TUNE_CTRL_STEP;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, max);
-		if (esdhc_send_tuning_cmd(host, opcode, &sg)) {
+		if (mmc_send_tuning(host->mmc)) {
 			max -= ESDHC_TUNE_CTRL_STEP;
 			break;
 		}
@@ -796,11 +736,9 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	/* use average delay to get the best timing */
 	avg = (min + max) / 2;
 	esdhc_prepare_tuning(host, avg);
-	ret = esdhc_send_tuning_cmd(host, opcode, &sg);
+	ret = mmc_send_tuning(host->mmc);
 	esdhc_post_tuning(host);
 
-	kfree(tuning_pattern);
-
 	dev_dbg(mmc_dev(host->mmc), "tunning %s at 0x%x ret %d\n",
 		ret ? "failed" : "passed", avg, ret);
 
-- 
1.9.1


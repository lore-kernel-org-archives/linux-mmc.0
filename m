From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 18/38] mmc: sdhci-esdhc-imx: avoid DMA to kernel stack
Date: Wed, 23 Apr 2014 20:07:42 +0100
Message-ID: <E1Wd2WE-0003vU-7h@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46438 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932222AbaDWTHp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:07:45 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

sdhci-esdhc-imx tries to DMA to the kernel stack when tuning the
interface, which causes dma-debug to complain.  Fix this by kmallocing
a buffer to hold the received tuning pattern.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ce8939ff97a4..5acfe2fc4fe0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -711,13 +711,12 @@ static void esdhc_request_done(struct mmc_request *mrq)
 	complete(&mrq->completion);
 }
 
-static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode)
+static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode,
+				 struct scatterlist *sg)
 {
 	struct mmc_command cmd = {0};
 	struct mmc_request mrq = {NULL};
 	struct mmc_data data = {0};
-	struct scatterlist sg;
-	char tuning_pattern[ESDHC_TUNING_BLOCK_PATTERN_LEN];
 
 	cmd.opcode = opcode;
 	cmd.arg = 0;
@@ -726,11 +725,9 @@ static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode)
 	data.blksz = ESDHC_TUNING_BLOCK_PATTERN_LEN;
 	data.blocks = 1;
 	data.flags = MMC_DATA_READ;
-	data.sg = &sg;
+	data.sg = sg;
 	data.sg_len = 1;
 
-	sg_init_one(&sg, tuning_pattern, sizeof(tuning_pattern));
-
 	mrq.cmd = &cmd;
 	mrq.cmd->mrq = &mrq;
 	mrq.data = &data;
@@ -770,13 +767,21 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 
 static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 {
+	struct scatterlist sg;
+	char *tuning_pattern;
 	int min, max, avg, ret;
 
+	tuning_pattern = kmalloc(ESDHC_TUNING_BLOCK_PATTERN_LEN, GFP_KERNEL);
+	if (!tuning_pattern)
+		return -ENOMEM;
+
+	sg_init_one(&sg, tuning_pattern, ESDHC_TUNING_BLOCK_PATTERN_LEN);
+
 	/* find the mininum delay first which can pass tuning */
 	min = ESDHC_TUNE_CTRL_MIN;
 	while (min < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, min);
-		if (!esdhc_send_tuning_cmd(host, opcode))
+		if (!esdhc_send_tuning_cmd(host, opcode, &sg))
 			break;
 		min += ESDHC_TUNE_CTRL_STEP;
 	}
@@ -785,7 +790,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	max = min + ESDHC_TUNE_CTRL_STEP;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, max);
-		if (esdhc_send_tuning_cmd(host, opcode)) {
+		if (esdhc_send_tuning_cmd(host, opcode, &sg)) {
 			max -= ESDHC_TUNE_CTRL_STEP;
 			break;
 		}
@@ -795,9 +800,11 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	/* use average delay to get the best timing */
 	avg = (min + max) / 2;
 	esdhc_prepare_tuning(host, avg);
-	ret = esdhc_send_tuning_cmd(host, opcode);
+	ret = esdhc_send_tuning_cmd(host, opcode, &sg);
 	esdhc_post_tuning(host);
 
+	kfree(tuning_pattern);
+
 	dev_dbg(mmc_dev(host->mmc), "tunning %s at 0x%x ret %d\n",
 		ret ? "failed" : "passed", avg, ret);
 
-- 
1.8.3.1


From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 20/31] mmc: sdhci-esdhc-imx: avoid DMA to kernel stack
Date: Tue, 18 Feb 2014 15:10:45 +0000
Message-ID: <E1WFmJp-0006nC-Iv@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40525 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755560AbaBRPKt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:49 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

sdhci-esdhc-imx tries to DMA to the kernel stack when tuning the
interface, which causes dma-debug to complain.  Fix this by kmallocing
a buffer to hold the received tuning pattern.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-esdhc-imx.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ce8939ff97a4..5acfe2fc4fe0 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -711,13 +711,12 @@ static void esdhc_request_done(struct mmc_request *mrq)
 	complete(&mrq->completion);
 }
 
-static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode)
=+DO NOT APPLY+=static int esdhc_send_tuning_cmd(struct sdhci_host *host, u32 opcode,
=+DO NOT APPLY+=				 struct scatterlist *sg)
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
=+DO NOT APPLY+=	data.sg = sg;
 	data.sg_len = 1;
 
-	sg_init_one(&sg, tuning_pattern, sizeof(tuning_pattern));
-
 	mrq.cmd = &cmd;
 	mrq.cmd->mrq = &mrq;
 	mrq.data = &data;
@@ -770,13 +767,21 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 
 static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 {
=+DO NOT APPLY+=	struct scatterlist sg;
=+DO NOT APPLY+=	char *tuning_pattern;
 	int min, max, avg, ret;
 
=+DO NOT APPLY+=	tuning_pattern = kmalloc(ESDHC_TUNING_BLOCK_PATTERN_LEN, GFP_KERNEL);
=+DO NOT APPLY+=	if (!tuning_pattern)
=+DO NOT APPLY+=		return -ENOMEM;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	sg_init_one(&sg, tuning_pattern, ESDHC_TUNING_BLOCK_PATTERN_LEN);
=+DO NOT APPLY+=
 	/* find the mininum delay first which can pass tuning */
 	min = ESDHC_TUNE_CTRL_MIN;
 	while (min < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, min);
-		if (!esdhc_send_tuning_cmd(host, opcode))
=+DO NOT APPLY+=		if (!esdhc_send_tuning_cmd(host, opcode, &sg))
 			break;
 		min += ESDHC_TUNE_CTRL_STEP;
 	}
@@ -785,7 +790,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	max = min + ESDHC_TUNE_CTRL_STEP;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
 		esdhc_prepare_tuning(host, max);
-		if (esdhc_send_tuning_cmd(host, opcode)) {
=+DO NOT APPLY+=		if (esdhc_send_tuning_cmd(host, opcode, &sg)) {
 			max -= ESDHC_TUNE_CTRL_STEP;
 			break;
 		}
@@ -795,9 +800,11 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	/* use average delay to get the best timing */
 	avg = (min + max) / 2;
 	esdhc_prepare_tuning(host, avg);
-	ret = esdhc_send_tuning_cmd(host, opcode);
=+DO NOT APPLY+=	ret = esdhc_send_tuning_cmd(host, opcode, &sg);
 	esdhc_post_tuning(host);
 
=+DO NOT APPLY+=	kfree(tuning_pattern);
=+DO NOT APPLY+=
 	dev_dbg(mmc_dev(host->mmc), "tunning %s at 0x%x ret %d\n",
 		ret ? "failed" : "passed", avg, ret);
 
-- 
1.8.3.1


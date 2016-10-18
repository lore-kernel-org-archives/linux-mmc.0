From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 4/8] mmc: core: remove BUG_ONs from sd
Date: Tue, 18 Oct 2016 20:04:11 +0800
Message-ID: <1476792251-6431-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:57516 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757966AbcJRL61 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 07:58:27 -0400
In-Reply-To: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

BUG_ONs doesn't help anything except for stop the system from
running. If it occurs, it implies we should deploy proper error
handling for that. So this patch is gonna discard these meaningless
BUG_ONs and deploy error handling if needed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/sd.c     | 20 +++++++++-----------
 drivers/mmc/core/sd_ops.c | 30 ++++++++++--------------------
 2 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 73c762a..bd3ddcc 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -927,7 +927,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	u32 cid[4];
 	u32 rocr = 0;
 
-	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
 	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
@@ -1043,9 +1042,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
  */
 static void mmc_sd_remove(struct mmc_host *host)
 {
-	BUG_ON(!host);
-	BUG_ON(!host->card);
-
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
@@ -1065,8 +1061,8 @@ static void mmc_sd_detect(struct mmc_host *host)
 {
 	int err;
 
-	BUG_ON(!host);
-	BUG_ON(!host->card);
+	if (!host)
+		return;
 
 	mmc_get_card(host->card);
 
@@ -1091,8 +1087,8 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 {
 	int err = 0;
 
-	BUG_ON(!host);
-	BUG_ON(!host->card);
+	if (!host)
+		return -EINVAL;
 
 	mmc_claim_host(host);
 
@@ -1136,8 +1132,8 @@ static int _mmc_sd_resume(struct mmc_host *host)
 {
 	int err = 0;
 
-	BUG_ON(!host);
-	BUG_ON(!host->card);
+	if (!host)
+		return -EINVAL;
 
 	mmc_claim_host(host);
 
@@ -1221,7 +1217,9 @@ int mmc_attach_sd(struct mmc_host *host)
 	int err;
 	u32 ocr, rocr;
 
-	BUG_ON(!host);
+	if (!host)
+		return -EINVAL;
+
 	WARN_ON(!host->claimed);
 
 	err = mmc_send_app_op_cond(host, 0, &ocr);
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 16b774c..a2cc157 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -27,8 +27,8 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	int err;
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!host);
-	BUG_ON(card && (card->host != host));
+	if (WARN_ON(card && card->host != host))
+		return -EINVAL;
 
 	cmd.opcode = MMC_APP_CMD;
 
@@ -72,8 +72,8 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 
 	int i, err;
 
-	BUG_ON(!cmd);
-	BUG_ON(retries < 0);
+	if (retries < 0)
+		retries = MMC_CMD_RETRIES;
 
 	err = -EIO;
 
@@ -122,9 +122,6 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
 {
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-
 	cmd.opcode = SD_APP_SET_BUS_WIDTH;
 	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
@@ -147,8 +144,6 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	struct mmc_command cmd = {0};
 	int i, err = 0;
 
-	BUG_ON(!host);
-
 	cmd.opcode = SD_APP_OP_COND;
 	if (mmc_host_is_spi(host))
 		cmd.arg = ocr & (1 << 30); /* SPI only defines one bit */
@@ -224,8 +219,8 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
 	int err;
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!host);
-	BUG_ON(!rca);
+	if (!rca)
+		return -ENOMEM;
 
 	cmd.opcode = SD_SEND_RELATIVE_ADDR;
 	cmd.arg = 0;
@@ -249,9 +244,8 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 	struct scatterlist sg;
 	void *data_buf;
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-	BUG_ON(!scr);
+	if (!scr)
+		return -ENOMEM;
 
 	/* NOTE: caller guarantees scr is heap-allocated */
 
@@ -307,9 +301,6 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	struct mmc_data data = {0};
 	struct scatterlist sg;
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-
 	/* NOTE: caller guarantees resp is heap-allocated */
 
 	mode = !!mode;
@@ -352,9 +343,8 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	struct mmc_data data = {0};
 	struct scatterlist sg;
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-	BUG_ON(!ssr);
+	if (!ssr)
+		return -ENOMEM;
 
 	/* NOTE: caller guarantees ssr is heap-allocated */
 
-- 
2.3.7



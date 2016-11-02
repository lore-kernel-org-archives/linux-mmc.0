From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/8] mmc: core: remove BUG_ONs from mmc
Date: Wed,  2 Nov 2016 15:25:33 +0800
Message-ID: <1478071533-12775-1-git-send-email-shawn.lin@rock-chips.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:60756 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbcKBH0E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2016 03:26:04 -0400
In-Reply-To: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com>
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

 drivers/mmc/core/mmc.c     | 14 --------------
 drivers/mmc/core/mmc_ops.c | 17 -----------------
 2 files changed, 31 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e811bd9..4763a35 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1464,7 +1464,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	u32 cid[4];
 	u32 rocr;
 
-	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
 	/* Set correct bus mode for MMC before attempting init */
@@ -1854,9 +1853,6 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
  */
 static void mmc_remove(struct mmc_host *host)
 {
-	BUG_ON(!host);
-	BUG_ON(!host->card);
-
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
@@ -1876,9 +1872,6 @@ static void mmc_detect(struct mmc_host *host)
 {
 	int err;
 
-	BUG_ON(!host);
-	BUG_ON(!host->card);
-
 	mmc_get_card(host->card);
 
 	/*
@@ -1904,9 +1897,6 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
 					EXT_CSD_POWER_OFF_LONG;
 
-	BUG_ON(!host);
-	BUG_ON(!host->card);
-
 	mmc_claim_host(host);
 
 	if (mmc_card_suspended(host->card))
@@ -1963,9 +1953,6 @@ static int _mmc_resume(struct mmc_host *host)
 {
 	int err = 0;
 
-	BUG_ON(!host);
-	BUG_ON(!host->card);
-
 	mmc_claim_host(host);
 
 	if (!mmc_card_suspended(host->card))
@@ -2098,7 +2085,6 @@ int mmc_attach_mmc(struct mmc_host *host)
 	int err;
 	u32 ocr, rocr;
 
-	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
 	/* Set correct bus mode for MMC before attempting attach */
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 481bbdb..2bc4780 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -60,9 +60,6 @@ static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
 	int err;
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-
 	cmd.opcode = MMC_SEND_STATUS;
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
@@ -92,8 +89,6 @@ static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!host);
-
 	cmd.opcode = MMC_SELECT_CARD;
 
 	if (card) {
@@ -109,7 +104,6 @@ static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 
 int mmc_select_card(struct mmc_card *card)
 {
-	BUG_ON(!card);
 
 	return _mmc_select_card(card->host, card);
 }
@@ -181,8 +175,6 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	struct mmc_command cmd = {0};
 	int i, err = 0;
 
-	BUG_ON(!host);
-
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
@@ -221,9 +213,6 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
 	int err;
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!host);
-	BUG_ON(!cid);
-
 	cmd.opcode = MMC_ALL_SEND_CID;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_R2 | MMC_CMD_BCR;
@@ -241,9 +230,6 @@ int mmc_set_relative_addr(struct mmc_card *card)
 {
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-
 	cmd.opcode = MMC_SET_RELATIVE_ADDR;
 	cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -257,9 +243,6 @@ mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
 	int err;
 	struct mmc_command cmd = {0};
 
-	BUG_ON(!host);
-	BUG_ON(!cxd);
-
 	cmd.opcode = opcode;
 	cmd.arg = arg;
 	cmd.flags = MMC_RSP_R2 | MMC_CMD_AC;
-- 
2.3.7



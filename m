From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] mmc: test: prepare sbc for preceding ACMD23 multiple block write
Date: Wed, 27 Sep 2017 11:40:37 +0800
Message-ID: <1506483638-115756-2-git-send-email-shawn.lin@rock-chips.com>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:38951 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969859AbdI0Dlw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2017 23:41:52 -0400
In-Reply-To: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Enable preceding ACMD23 for testing multiple block write for the
sd cards which don't claim to support CMD23.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/mmc_test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 4788698..c941ba9 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -198,17 +198,26 @@ static void mmc_test_prepare_sbc(struct mmc_test_card *test,
 				 struct mmc_request *mrq, unsigned int blocks)
 {
 	struct mmc_card *card = test->card;
+	bool need_acmd23 = false;
 
 	if (!mrq->sbc || !mmc_host_cmd23(card->host) ||
 	    !mmc_test_card_cmd23(card) || !mmc_op_multi(mrq->cmd->opcode) ||
 	    (card->quirks & MMC_QUIRK_BLK_NO_CMD23)) {
+		need_acmd23 = mmc_card_sd(card) &&
+			      mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK;
+		if (need_acmd23)
+			goto prepare_sbc;
+
 		mrq->sbc = NULL;
 		return;
 	}
 
+prepare_sbc:
 	mrq->sbc->opcode = MMC_SET_BLOCK_COUNT;
 	mrq->sbc->arg = blocks;
 	mrq->sbc->flags = MMC_RSP_R1 | MMC_CMD_AC;
+	if (need_acmd23)
+		mrq->sbc->flags |= MMC_CMD_SD_APP;
 }
 
 /*
-- 
1.9.1



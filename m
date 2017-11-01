From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/3] mmc: test: prepare sbc for preceding ACMD23 multiple block write
Date: Wed,  1 Nov 2017 09:37:12 +0800
Message-ID: <1509500233-133821-2-git-send-email-shawn.lin@rock-chips.com>
References: <1509500233-133821-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:47175 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754044AbdKABjR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Oct 2017 21:39:17 -0400
In-Reply-To: <1509500233-133821-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jan Glauber <jglauber@cavium.com>, Shawn Lin <shawn.lin@rock-chips.com>

Enable preceding ACMD23 for testing multiple block write for the
sd cards which don't claim to support CMD23.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

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



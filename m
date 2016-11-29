From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V8 11/20] mmc: mmc_test: Disable Command Queue while mmc_test is used
Date: Tue, 29 Nov 2016 12:09:18 +0200
Message-ID: <1480414167-15577-12-git-send-email-adrian.hunter@intel.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756889AbcK2KPQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Nov 2016 05:15:16 -0500
In-Reply-To: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Normal read and write commands may not be used while the command queue is
enabled. Disable the Command Queue when mmc_test is probed and re-enable it
when it is removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>
---
 drivers/mmc/card/mmc_test.c | 13 +++++++++++++
 drivers/mmc/core/mmc.c      |  7 +++++++
 include/linux/mmc/card.h    |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 5ba6d77b9723..b42c23665104 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -3264,6 +3264,14 @@ static int mmc_test_probe(struct mmc_card *card)
 	if (ret)
 		return ret;
 
+	if (card->ext_csd.cmdq_en) {
+		mmc_claim_host(card->host);
+		ret = mmc_cmdq_disable(card);
+		mmc_release_host(card->host);
+		if (ret)
+			return ret;
+	}
+
 	dev_info(&card->dev, "Card claimed for testing.\n");
 
 	return 0;
@@ -3271,6 +3279,11 @@ static int mmc_test_probe(struct mmc_card *card)
 
 static void mmc_test_remove(struct mmc_card *card)
 {
+	if (card->reenable_cmdq) {
+		mmc_claim_host(card->host);
+		mmc_cmdq_enable(card);
+		mmc_release_host(card->host);
+	}
 	mmc_test_free_result(card);
 	mmc_test_free_dbgfs_file(card);
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 76432ebc0b06..720759a81296 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1756,6 +1756,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
+	 * disabled for a time, so a flag is needed to indicate to re-enable the
+	 * Command Queue.
+	 */
+	card->reenable_cmdq = card->ext_csd.cmdq_en;
+
+	/*
 	 * The mandatory minimum values are defined for packed command.
 	 * read: 5, write: 3
 	 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 2d9c24f4e88e..5ac2243bc5a9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -273,6 +273,7 @@ struct mmc_card {
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
 
+	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
-- 
1.9.1


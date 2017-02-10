From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 06/39] mmc: mmc_test: Disable Command Queue while mmc_test is used
Date: Fri, 10 Feb 2017 14:55:19 +0200
Message-ID: <1486731352-8018-7-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25598 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdBJN21 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:28:27 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
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
 drivers/mmc/core/mmc.c      |  7 +++++++
 drivers/mmc/core/mmc_test.c | 14 ++++++++++++++
 include/linux/mmc/card.h    |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index df154b951a10..8c290264cf2d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1800,6 +1800,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 45e623cc1624..e6f1c3fae849 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -26,6 +26,7 @@
 #include "card.h"
 #include "host.h"
 #include "bus.h"
+#include "mmc_ops.h"
 
 #define RESULT_OK		0
 #define RESULT_FAIL		1
@@ -3264,6 +3265,14 @@ static int mmc_test_probe(struct mmc_card *card)
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
@@ -3271,6 +3280,11 @@ static int mmc_test_probe(struct mmc_card *card)
 
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
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 94637796b99c..85b5f2bc8bb9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -269,6 +269,8 @@ struct mmc_card {
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
 
+	bool			reenable_cmdq;	/* Re-enable Command Queue */
+
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
  	unsigned int		pref_erase;	/* in sectors */
-- 
1.9.1


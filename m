From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V9 11/11] mmc: mmc: Enable Software Command Queuing
Date: Thu,  8 Dec 2016 10:44:38 +0200
Message-ID: <1481186678-6307-12-git-send-email-adrian.hunter@intel.com>
References: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750851AbcLHIu2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 03:50:28 -0500
In-Reply-To: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Enable the Command Queue if the host controller supports Software Command
Queuing. It is not compatible with Packed Commands, so do not enable that
at the same time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index dbdbc6d12de2..0717a87921b6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1765,6 +1765,20 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/* Enable Command Queue if supported */
+	card->ext_csd.cmdq_en = false;
+	if (card->ext_csd.cmdq_support && host->caps & MMC_CAP_CMD_DURING_TFR) {
+		err = mmc_cmdq_enable(card);
+		if (err && err != -EBADMSG)
+			goto free_card;
+		if (err) {
+			pr_warn("%s: Enabling CMDQ failed\n",
+				mmc_hostname(card->host));
+			card->ext_csd.cmdq_support = false;
+			card->ext_csd.cmdq_depth = 0;
+			err = 0;
+		}
+	}
 	/*
 	 * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
 	 * disabled for a time, so a flag is needed to indicate to re-enable the
@@ -1778,7 +1792,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (card->ext_csd.max_packed_writes >= 3 &&
 	    card->ext_csd.max_packed_reads >= 5 &&
-	    host->caps2 & MMC_CAP2_PACKED_CMD) {
+	    host->caps2 & MMC_CAP2_PACKED_CMD &&
+	    !card->ext_csd.cmdq_en) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_EXP_EVENTS_CTRL,
 				EXT_CSD_PACKED_EVENT_EN,
-- 
1.9.1


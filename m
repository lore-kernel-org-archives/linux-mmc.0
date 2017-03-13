From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 18/22] mmc: mmc: Enable Command Queuing
Date: Mon, 13 Mar 2017 14:36:49 +0200
Message-ID: <1489408613-26915-19-git-send-email-adrian.hunter@intel.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:25133 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752405AbdCMMoR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Mar 2017 08:44:17 -0400
In-Reply-To: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Enable the Command Queue if the host controller supports i a command queue
engine. It is not compatible with Packed Commands, so do not enable that
at the same time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d1f0c4b247ac..70337068d85f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1789,6 +1789,20 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/* Enable Command Queue if supported */
+	card->ext_csd.cmdq_en = false;
+	if (card->ext_csd.cmdq_support && host->caps2 & MMC_CAP2_CQE) {
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
@@ -1802,7 +1816,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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


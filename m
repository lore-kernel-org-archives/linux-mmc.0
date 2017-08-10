From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 06/13] mmc: core: Remove unused MMC_CAP2_PACKED_CMD
Date: Thu, 10 Aug 2017 15:08:11 +0300
Message-ID: <1502366898-23691-7-git-send-email-adrian.hunter@intel.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61492 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbdHJMPK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 10 Aug 2017 08:15:10 -0400
In-Reply-To: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Packed commands support was removed but some bits got left behind. Remove
them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c   | 23 -----------------------
 include/linux/mmc/host.h |  4 ----
 2 files changed, 27 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index adb5c88fd054..5fcb8d721224 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1790,29 +1790,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	card->reenable_cmdq = card->ext_csd.cmdq_en;
 
-	/*
-	 * The mandatory minimum values are defined for packed command.
-	 * read: 5, write: 3
-	 */
-	if (card->ext_csd.max_packed_writes >= 3 &&
-	    card->ext_csd.max_packed_reads >= 5 &&
-	    host->caps2 & MMC_CAP2_PACKED_CMD) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_EXP_EVENTS_CTRL,
-				EXT_CSD_PACKED_EVENT_EN,
-				card->ext_csd.generic_cmd6_time);
-		if (err && err != -EBADMSG)
-			goto free_card;
-		if (err) {
-			pr_warn("%s: Enabling packed event failed\n",
-				mmc_hostname(card->host));
-			card->ext_csd.packed_event_en = 0;
-			err = 0;
-		} else {
-			card->ext_csd.packed_event_en = 1;
-		}
-	}
-
 	if (!oldcard)
 		host->card = card;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 89e1d7e2953e..5f3eb4a0373f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -335,10 +335,6 @@ struct mmc_host {
 				 MMC_CAP2_HS200_1_2V_SDR)
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
-#define MMC_CAP2_PACKED_RD	(1 << 12)	/* Allow packed read */
-#define MMC_CAP2_PACKED_WR	(1 << 13)	/* Allow packed write */
-#define MMC_CAP2_PACKED_CMD	(MMC_CAP2_PACKED_RD | \
-				 MMC_CAP2_PACKED_WR)
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
 #define MMC_CAP2_HS400_1_8V	(1 << 15)	/* Can support HS400 1.8V */
 #define MMC_CAP2_HS400_1_2V	(1 << 16)	/* Can support HS400 1.2V */
-- 
1.9.1


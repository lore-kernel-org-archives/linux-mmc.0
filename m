From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 23/25] mmc: mmc: Enable Software Command Queuing
Date: Fri, 25 Nov 2016 12:07:20 +0200
Message-ID: <1480068442-5169-24-git-send-email-adrian.hunter@intel.com>
References: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:16412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbcKYKOU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Nov 2016 05:14:20 -0500
In-Reply-To: <1480068442-5169-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Enable the Command Queue if the host controller supports Software Command
Queuing. It is not compatible with Packed Commands, so do not enable that
at the same time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c   | 17 ++++++++++++++++-
 include/linux/mmc/host.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e310a60ef859..6a31a7a614be 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1754,6 +1754,20 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/* Enable Command Queue if supported */
+	card->ext_csd.cmdq_en = false;
+	if (card->ext_csd.cmdq_support && host->caps & MMC_CAP_SWCMDQ) {
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
@@ -1767,7 +1781,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (card->ext_csd.max_packed_writes >= 3 &&
 	    card->ext_csd.max_packed_reads >= 5 &&
-	    host->caps2 & MMC_CAP2_PACKED_CMD) {
+	    host->caps2 & MMC_CAP2_PACKED_CMD &&
+	    !card->ext_csd.cmdq_en) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_EXP_EVENTS_CTRL,
 				EXT_CSD_PACKED_EVENT_EN,
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index fa44aa93505a..ea514470c0c1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -279,6 +279,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_SWCMDQ		(1 << 28)	/* Software Command Queue */
 #define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
-- 
1.9.1


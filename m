From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: mmc: Improve reliability of mmc_select_hs200()
Date: Wed, 28 Oct 2015 14:25:40 +0200
Message-ID: <1446035143-4949-2-git-send-email-adrian.hunter@intel.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57266 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbbJ1M3M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2015 08:29:12 -0400
In-Reply-To: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

Currently mmc_select_hs200() uses __mmc_switch() which checks the
success of the switch to HS200 mode using CMD13 (SEND_STATUS).
The problem is that it does that using the timing settings of legacy
mode.  That is prone to error, not least because the timing parameters
for legacy mode are tighter than the timing parameters for HS200 mode.

In the case when CMD13 polling is used (i.e. not MMC_CAP_WAIT_WHILE_BUSY)
with the switch command, it must be assumed that using different modes on
the card and host must work.

However in the case when CMD13 polling is not used
(i.e. MMC_CAP_WAIT_WHILE_BUSY) mmc_select_hs200() can be made more
reliable by setting the host to the correct timing before sending CMD13.

This patch does that.

A complication is that the caller, mmc_select_timing(), will ignore a
switch error (indicated by -EBADMSG), assume the old mode is valid
and continue, so the old timing must be restored in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c793fda27321..2cef40ce9851 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1219,6 +1219,8 @@ static void mmc_select_driver_type(struct mmc_card *card)
 static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
+	bool send_status = true;
+	unsigned int old_timing;
 	int err = -EINVAL;
 	u8 val;
 
@@ -1234,6 +1236,9 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	mmc_select_driver_type(card);
 
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		send_status = false;
+
 	/*
 	 * Set the bus width(4 or 8) with host's support and
 	 * switch to HS200 mode if bus width is set successfully.
@@ -1245,11 +1250,25 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time,
-				   true, true, true);
-		if (!err)
-			mmc_set_timing(host, MMC_TIMING_MMC_HS200);
+				   true, send_status, true);
+		if (err)
+			goto err;
+		old_timing = host->ios.timing;
+		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
+		if (!send_status) {
+			err = mmc_switch_status(card);
+			/*
+			 * mmc_select_timing() assumes timing has not changed if
+			 * it is a switch error.
+			 */
+			if (err == -EBADMSG)
+				mmc_set_timing(host, old_timing);
+		}
 	}
 err:
+	if (err)
+		pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
+		       __func__, err);
 	return err;
 }
 
-- 
1.9.1


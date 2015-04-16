From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V6 07/15] mmc: core: Hold re-tuning while bkops ongoing
Date: Thu, 16 Apr 2015 14:54:16 +0300
Message-ID: <1429185256-17534-1-git-send-email-adrian.hunter@intel.com>
References: <CAPDyKFp0266csi73LPMenigqu+tf1V_yMD6F+sqYy8noaSUKxw@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40616 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757288AbbDPL4a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Apr 2015 07:56:30 -0400
In-Reply-To: <CAPDyKFp0266csi73LPMenigqu+tf1V_yMD6F+sqYy8noaSUKxw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hold re-tuning during bkops to prevent
it from conflicting with the busy state.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---



Changes in V6:

	Hold re-tuning always and release only if
	bkops is not ongoing.



 drivers/mmc/core/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index dbd7a77..7aae0ff 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -318,12 +318,15 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 		use_busy_signal = false;
 	}
 
+	mmc_retune_hold(card->host);
+
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_BKOPS_START, 1, timeout,
 			use_busy_signal, true, false);
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
+		mmc_retune_release(card->host);
 		goto out;
 	}
 
@@ -334,6 +337,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	 */
 	if (!use_busy_signal)
 		mmc_card_set_doing_bkops(card);
+	else
+		mmc_retune_release(card->host);
 out:
 	mmc_release_host(card->host);
 }
@@ -749,6 +754,7 @@ int mmc_stop_bkops(struct mmc_card *card)
 	 */
 	if (!err || (err == -EINVAL)) {
 		mmc_card_clr_doing_bkops(card);
+		mmc_retune_release(card->host);
 		err = 0;
 	}
 
-- 
1.9.1


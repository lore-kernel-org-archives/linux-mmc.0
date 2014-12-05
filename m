From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/13] mmc: core: Add support for HS400 re-tuning
Date: Fri,  5 Dec 2014 19:41:09 +0200
Message-ID: <1417801271-15575-12-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60360 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbaLERnq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:46 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

HS400 re-tuning must be done in HS200 mode. Add
the ability to switch from HS400 mode to HS200
mode before re-tuning and switch back to HS400
after re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/host.c | 17 +++++++++++++++++
 drivers/mmc/core/mmc.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 1b022c9..2a7d9219 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -84,6 +84,8 @@ void mmc_remove_card_debugfs(struct mmc_card *card);
 void mmc_init_context_info(struct mmc_host *host);
 
 int mmc_execute_tuning(struct mmc_card *card);
+int mmc_hs200_to_hs400(struct mmc_card *card);
+int mmc_hs400_to_hs200(struct mmc_card *card);
 
 #endif
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index a4aa25b..62c4770 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -318,6 +318,7 @@ void mmc_retune_timer_stop(struct mmc_host *host)
 
 int mmc_retune(struct mmc_host *host)
 {
+	bool return_to_hs400 = false;
 	int err;
 
 	if (!host->need_retune || host->doing_retune || host->hold_retune ||
@@ -328,8 +329,24 @@ int mmc_retune(struct mmc_host *host)
 
 	host->doing_retune = 1;
 
+	if (host->ios.timing == MMC_TIMING_MMC_HS400) {
+		err = mmc_hs400_to_hs200(host->card);
+		if (err)
+			goto out;
+
+		return_to_hs400 = true;
+
+		if (host->ops->prepare_hs400_tuning)
+			host->ops->prepare_hs400_tuning(host, &host->ios);
+	}
+
 	err = mmc_execute_tuning(host->card);
+	if (err)
+		goto out;
 
+	if (return_to_hs400)
+		err = mmc_hs200_to_hs400(host->card);
+out:
 	host->doing_retune = 0;
 
 	return err;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7a913e6..167340c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1081,6 +1081,49 @@ static int mmc_select_hs400(struct mmc_card *card)
 	return 0;
 }
 
+int mmc_hs200_to_hs400(struct mmc_card *card)
+{
+	return mmc_select_hs400(card);
+}
+
+int mmc_hs400_to_hs200(struct mmc_card *card)
+{
+	unsigned int max_dtr;
+	int err;
+
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(card->host, max_dtr);
+
+	/* Switch HS400 to HS DDR */
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
+			   EXT_CSD_TIMING_HS, card->ext_csd.generic_cmd6_time,
+			   true, true, true);
+	if (err)
+		return err;
+
+	mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
+
+	/* Switch HS DDR to HS */
+	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
+			 EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time);
+	if (err)
+		return err;
+
+	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+
+	/* Switch HS to HS200 */
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
+			   EXT_CSD_TIMING_HS200,
+			   card->ext_csd.generic_cmd6_time, true, true, true);
+	if (err)
+		return err;
+
+	mmc_set_timing(card->host, MMC_TIMING_MMC_HS200);
+
+	return err;
+}
+
 /*
  * For device supporting HS200 mode, the following sequence
  * should be done before executing the tuning process.
-- 
1.9.1


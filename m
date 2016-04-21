From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 3/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Thu, 21 Apr 2016 16:28:34 +0300
Message-ID: <1461245314-6282-4-git-send-email-adrian.hunter@intel.com>
References: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12239 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbcDUNc2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2016 09:32:28 -0400
In-Reply-To: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

The RPMB partition only allows certain commands.  In particular,
the tuning command (CMD21) is not allowed -  refer JEDEC eMMC
standard v5.1 section 6.2.2 Command restrictions.

To avoid tuning for RPMB, switch to High Speed mode from HS200
or HS400 mode if re-tuning has been enabled.  And switch back
when leaving RPMB.

In the case of HS400, this uses mode transitions that get used
anyway for re-tuning, so we may expect them to work.

In the case of HS200, this assumes it is OK to switch HS200 to
High Speed mode, which is at least not contradicted by the JEDEC
standard.

No attempt is made to recover from any error on the expectation
that subsequent block request failures will cause recovery via
mmc_blk_reset().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 36 +++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  2 +-
 include/linux/mmc/core.h |  3 +++
 include/linux/mmc/host.h |  5 ++++
 5 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 8a0147dfed27..596edef4dd24 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -733,6 +733,36 @@ static const struct block_device_operations mmc_bdops = {
 #endif
 };
 
+static int mmc_blk_pre_rpmb(struct mmc_card *card, struct mmc_blk_data *md)
+{
+	int ret;
+
+	if (md->part_type != EXT_CSD_PART_CONFIG_ACC_RPMB)
+		return 0;
+
+	ret = mmc_exit_tuning_mode(card);
+	if (ret < 0)
+		return ret;
+
+	card->post_rpmb_mode = ret;
+
+	return 0;
+}
+
+static void mmc_blk_post_rpmb(struct mmc_card *card,
+			      struct mmc_blk_data *main_md)
+{
+	int ret;
+
+	if (main_md->part_curr != EXT_CSD_PART_CONFIG_ACC_RPMB)
+		return;
+
+	ret = mmc_reenter_tuning_mode(card, card->post_rpmb_mode);
+	if (ret)
+		pr_err("%s: Post RPMB, failed to reenter mode %u, error %d\n",
+		       mmc_hostname(card->host), card->post_rpmb_mode, ret);
+}
+
 static inline int mmc_blk_part_switch(struct mmc_card *card,
 				      struct mmc_blk_data *md)
 {
@@ -745,6 +775,10 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 	if (mmc_card_mmc(card)) {
 		u8 part_config = card->ext_csd.part_config;
 
+		ret = mmc_blk_pre_rpmb(card, md);
+		if (ret)
+			return ret;
+
 		part_config &= ~EXT_CSD_PART_CONFIG_ACC_MASK;
 		part_config |= md->part_type;
 
@@ -755,6 +789,8 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
 			return ret;
 
 		card->ext_csd.part_config = part_config;
+
+		mmc_blk_post_rpmb(card, main_md);
 	}
 
 	main_md->part_curr = md->part_type;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4f771c6088f7..37aa0baf4a76 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1408,6 +1408,75 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 	return mmc_execute_tuning(card);
 }
 
+static int mmc_hs_to_hs200(struct mmc_card *card)
+{
+	int err;
+
+	err = __mmc_hs_to_hs200(card);
+	if (err)
+		return err;
+
+	err = mmc_hs200_tuning(card);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mmc_exit_tuning_mode(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	int err;
+
+	if (!mmc_retune_enabled(host))
+		return 0;
+
+	switch (host->ios.timing) {
+	case MMC_TIMING_MMC_HS200:
+		/*
+		 * Shouldn't need re-tuning because the frequency first gets
+		 * reduced to the High Speed frequency.
+		 */
+		mmc_retune_disable(host);
+		err = mmc_hs200_to_hs(card);
+		if (err < 0)
+			return err;
+		return MMC_TIMING_MMC_HS200;
+	case MMC_TIMING_MMC_HS400:
+		/*
+		 * Must disable re-tuning to stop it interfering with the mode
+		 * switch, which is OK because we are following the same
+		 * sequence that re-tuning follows anyway.
+		 */
+		mmc_retune_disable(host);
+		err = mmc_hs400_to_hs(card);
+		if (err < 0)
+			return err;
+		return MMC_TIMING_MMC_HS400;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL(mmc_exit_tuning_mode);
+
+int mmc_reenter_tuning_mode(struct mmc_card *card, u8 mode)
+{
+	int err;
+
+	switch (mode) {
+	case MMC_TIMING_MMC_HS200:
+		return mmc_hs_to_hs200(card);
+	case MMC_TIMING_MMC_HS400:
+		err = mmc_hs_to_hs200(card);
+		if (err)
+			return err;
+		return mmc_hs200_to_hs400(card);
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL(mmc_reenter_tuning_mode);
+
 /*
  * Handle the detection and initialisation of a card.
  *
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151bac50c..fdf5e5341386 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -279,7 +279,7 @@ struct mmc_card {
 #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)	/* Skip secure for erase/trim */
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
-
+	u8			post_rpmb_mode;	/* Mode to restore after RPMB */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b01e77de1a74..a5aeb44d3fc0 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -182,6 +182,9 @@ extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 extern int mmc_hw_reset(struct mmc_host *host);
 extern int mmc_can_reset(struct mmc_card *card);
 
+extern int mmc_exit_tuning_mode(struct mmc_card *card);
+extern int mmc_reenter_tuning_mode(struct mmc_card *card, u8 mode);
+
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
 extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 85800b48241f..6767adec8c84 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -526,4 +526,9 @@ static inline void mmc_retune_recheck(struct mmc_host *host)
 		host->retune_now = 1;
 }
 
+static inline bool mmc_retune_enabled(struct mmc_host *host)
+{
+	return host->can_retune;
+}
+
 #endif /* LINUX_MMC_HOST_H */
-- 
1.9.1


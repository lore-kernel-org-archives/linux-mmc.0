From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 03/10] mmc: core: Add command queue initialzation support
Date: Wed, 15 Jun 2016 18:31:07 +0530
Message-ID: <1465995674-15816-4-git-send-email-riteshh@codeaurora.org>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43658 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbcFONCa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:02:30 -0400
In-Reply-To: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>

From: Asutosh Das <asutoshd@codeaurora.org>

Command Queueing (CQ) feature is introduced to eMMC
standard in revision 5.1. CQ includes new commands
for issuing tasks to the device, for ordering the
execution of previously issued tasks and for
additional task management functions.

This patch adds initialization and enabling of command
queue in the card and controller. If the card and the
controller support CQ, then it is enabled.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
[subhashj@codeaurora.org: fixed trivial merge conflicts]
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
[riteshh@codeaurora.org: fixed trivial merge conflicts]
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/core/mmc.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  6 ++++++
 include/linux/mmc/host.h |  6 ++++++
 include/linux/mmc/mmc.h  |  1 +
 4 files changed, 63 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ff560e9..47f8d09 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1369,6 +1369,43 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 	return mmc_execute_tuning(card);
 }
 
+static int mmc_select_cmdq(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	int ret = 0;
+
+	if (!host->cmdq_ops) {
+		pr_err("%s: host controller doesn't support CMDQ\n",
+		       mmc_hostname(host));
+		return 0;
+	}
+
+	ret = mmc_set_blocklen(card, MMC_CARD_CMDQ_BLK_SIZE);
+	if (ret)
+		goto out;
+
+	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_CMDQ, 1,
+			 card->ext_csd.generic_cmd6_time);
+	if (ret)
+		goto out;
+
+	mmc_card_set_cmdq(card);
+	ret = host->cmdq_ops->enable(card->host);
+	if (ret) {
+		pr_err("%s: failed (%d) enabling CMDQ on host\n",
+			mmc_hostname(host), ret);
+		mmc_card_clr_cmdq(card);
+		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_CMDQ, 0,
+				 card->ext_csd.generic_cmd6_time);
+		if (ret)
+			goto out;
+	}
+
+	pr_info("%s: CMDQ enabled on card\n", mmc_hostname(host));
+out:
+	return ret;
+}
+
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -1397,6 +1434,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * respond.
 	 * mmc_go_idle is needed for eMMC that are asleep
 	 */
+reinit:
 	mmc_go_idle(host);
 
 	/* The extra bit indicates that we support high capacity */
@@ -1674,6 +1712,18 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!oldcard)
 		host->card = card;
 
+	if (card->ext_csd.cmdq_support && (card->host->caps2 &
+					   MMC_CAP2_CMD_QUEUE)) {
+		err = mmc_select_cmdq(card);
+		if (err) {
+			pr_err("%s: selecting CMDQ mode: failed: %d\n",
+					   mmc_hostname(card->host), err);
+			card->ext_csd.cmdq_support = 0;
+			oldcard = card;
+			goto reinit;
+		}
+	}
+
 	return 0;
 
 free_card:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f74db84..85a0d8d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -14,6 +14,8 @@
 #include <linux/mmc/core.h>
 #include <linux/mod_devicetable.h>
 
+#define MMC_CARD_CMDQ_BLK_SIZE 512
+
 struct mmc_cid {
 	unsigned int		manfid;
 	char			prod_name[8];
@@ -265,6 +267,7 @@ struct mmc_card {
 #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
 #define MMC_STATE_DOING_BKOPS	(1<<5)		/* card is doing BKOPS */
 #define MMC_STATE_SUSPENDED	(1<<6)		/* card is suspended */
+#define MMC_STATE_CMDQ		(1<<12)         /* card is in cmd queue mode */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -433,6 +436,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
 #define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
+#define mmc_card_cmdq(c)       ((c)->state & MMC_STATE_CMDQ)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -443,6 +447,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
 #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
 #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
+#define mmc_card_set_cmdq(c)           ((c)->state |= MMC_STATE_CMDQ)
+#define mmc_card_clr_cmdq(c)           ((c)->state &= ~MMC_STATE_CMDQ)
 
 /*
  * Quirk add/remove for MMC products.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 23accc3..96654d5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -79,6 +79,11 @@ struct mmc_ios {
 #define MMC_SET_DRIVER_TYPE_D	3
 };
 
+struct mmc_cmdq_host_ops {
+	int (*enable)(struct mmc_host *host);
+	void (*disable)(struct mmc_host *host, bool soft);
+};
+
 struct mmc_host_ops {
 	/*
 	 * It is optional for the host to implement pre_req and post_req in
@@ -221,6 +226,7 @@ struct mmc_host {
 	struct device		class_dev;
 	int			index;
 	const struct mmc_host_ops *ops;
+	const struct mmc_cmdq_host_ops *cmdq_ops;
 	struct mmc_pwrseq	*pwrseq;
 	unsigned int		f_min;
 	unsigned int		f_max;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 1c0ae75..c59c9df 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -272,6 +272,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_CMDQ			15	/* R/W */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.


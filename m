From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: [RFC/PATCH] mmc: core: Kill block requests if card is removed
Date: Wed, 12 Oct 2011 13:06:53 +0530
Message-ID: <1318405013-32434-1-git-send-email-sthumma@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:13058 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1JLHiM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2011 03:38:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-arm-msm@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>

Kill block requests when the host knows that the card is
removed from the slot and is sure that it can no longer
accept any requests.

Kill this silently so that the block layer don't output
error messages unnecessarily.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index fed290e..e1961db 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -29,6 +29,8 @@
  */
 static int mmc_prep_request(struct request_queue *q, struct request *req)
 {
+	struct mmc_queue *mq = q->queuedata;
+
 	/*
 	 * We only like normal block requests and discards.
 	 */
@@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
 		return BLKPREP_KILL;
 	}
 
+	if (mq && mq->card && !mmc_card_inserted(mq->card))
+		return BLKPREP_KILL;
+
 	req->cmd_flags |= REQ_DONTPREP;
 
 	return BLKPREP_OK;
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 46b6e84..ea3be5d 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -308,6 +308,7 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type, card->rca);
 	}
+	mmc_card_set_inserted(card);
 
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
@@ -340,6 +341,7 @@ void mmc_remove_card(struct mmc_card *card)
 			pr_info("%s: card %04x removed\n",
 				mmc_hostname(card->host), card->rca);
 		}
+		card->state &= ~MMC_STATE_INSERTED;
 		device_del(&card->dev);
 	}
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 0ea4a06..7cdbc14 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -196,6 +196,7 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_STATE_INSERTED      (1<<7)          /* card present in the slot */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -344,6 +345,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
+#define mmc_card_inserted(c)     ((c)->state & MMC_STATE_INSERTED)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
@@ -352,6 +354,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
+#define mmc_card_set_inserted(c) ((c)->state |= MMC_STATE_INSERTED)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
-- 
1.7.3.3

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

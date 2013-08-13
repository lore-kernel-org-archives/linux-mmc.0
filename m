From: "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH 2/7] mmc: lock: Add low level LOCK_UNLOCK command
Date: Tue, 13 Aug 2013 11:21:25 -0400
Message-ID: <1376407290-21477-3-git-send-email-alcooperx@gmail.com>
References: <1376407290-21477-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:2852 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757809Ab3HMPWT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Aug 2013 11:22:19 -0400
In-Reply-To: <1376407290-21477-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <acooper@broadcom.com>

From: Al Cooper <acooper@broadcom.com>

Add support for the LOCK_UNLOCK command. This command can lock,
unlock, set password, clear password and force erase SD and
MMC cards.

refs #SWLINUX-2545

Signed-off-by: Al Cooper <acooper@broadcom.com>
---
 drivers/mmc/core/mmc_ops.c | 112 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.h |  13 ++++++
 include/linux/mmc/card.h   |   5 ++
 3 files changed, 130 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 837fc73..26e37a1 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -13,6 +13,8 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/scatterlist.h>
+#include <linux/key.h>
+#include <linux/err.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -606,3 +608,113 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 
 	return 0;
 }
+
+#ifdef CONFIG_MMC_LOCK
+/**
+ *	mmc_lock_unlock - send LOCK_UNLOCK command to a specific card.
+ *	@card: card to which the LOCK_UNLOCK command should be sent
+ *	@key: key containing the MMC password
+ *	@mode: LOCK_UNLOCK mode
+ *
+ */
+int mmc_lock_unlock(struct mmc_card *card, struct mmc_password *password,
+		    int mode)
+{
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+	struct scatterlist sg;
+	unsigned long erase_timeout;
+	int err, data_size;
+	u8 *data_buf;
+
+	data_size = 4;
+	if (!(mode & MMC_LOCK_MODE_ERASE))
+		data_size = 2 + password->length;
+
+	data_buf = kzalloc(data_size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+	data_buf[0] |= mode;
+	if (!(mode & MMC_LOCK_MODE_ERASE)) {
+		data_buf[1] = password->length;
+		memcpy(data_buf + 2, password->password, password->length);
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = data_size;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
+	if (err)
+		goto out;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_LOCK_UNLOCK;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+	mmc_set_data_timeout(&data, card);
+	data.blksz = data_size;
+	data.blocks = 1;
+	data.flags = MMC_DATA_WRITE;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	sg_init_one(&sg, data_buf, data_size);
+	mmc_wait_for_req(card->host, &mrq);
+	if (cmd.error) {
+		err = cmd.error;
+		goto out;
+	}
+	if (data.error) {
+		err = data.error;
+		goto out;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	/* set timeout for forced erase operation to 3 min. (see MMC spec) */
+	erase_timeout = jiffies + 180 * HZ;
+	do {
+		/*
+		 * we cannot use "retries" here because the
+		 * R1_LOCK_UNLOCK_FAILED bit is cleared by subsequent reads to
+		 * the status register, hiding the error condition
+		 */
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (err)
+			break;
+		/* the other modes don't need timeout checking */
+		if (!(mode & MMC_LOCK_MODE_ERASE))
+			continue;
+		if (time_after(jiffies, erase_timeout) &&
+		    !(cmd.resp[0] & R1_READY_FOR_DATA)) {
+			dev_err(&card->dev, "forced erase timed out\n");
+			err = -ETIMEDOUT;
+			break;
+		}
+	} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
+	if (cmd.resp[0] & R1_LOCK_UNLOCK_FAILED) {
+		dev_dbg(&card->dev, "LOCK_UNLOCK operation failed\n");
+		err = -EIO;
+	}
+	if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+		mmc_card_set_locked(card);
+	else
+		mmc_card_clear_locked(card);
+
+out:
+	kfree(data_buf);
+
+	return err;
+}
+#endif /* CONFIG_MMC_LOCK */
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 80ae9f4..5fe50e0 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -12,6 +12,15 @@
 #ifndef _MMC_MMC_OPS_H
 #define _MMC_MMC_OPS_H
 
+/*
+ * MMC_LOCK_UNLOCK modes
+ */
+#define MMC_LOCK_MODE_ERASE	(1<<3)
+#define MMC_LOCK_MODE_LOCK	(1<<2)
+#define MMC_LOCK_MODE_UNLOCK	(0<<2)
+#define MMC_LOCK_MODE_CLR_PWD	(1<<1)
+#define MMC_LOCK_MODE_SET_PWD	(1<<0)
+
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
@@ -26,6 +35,10 @@ int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
+#ifdef CONFIG_MMC_LOCK
+int mmc_lock_unlock(struct mmc_card *card, struct mmc_password *password,
+		    int mode);
+#endif
 
 #endif
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 842de3e..af92c44 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -257,6 +257,7 @@ struct mmc_card {
 #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
 #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
 #define MMC_STATE_DOING_BKOPS	(1<<10)		/* card is doing BKOPS */
+#define MMC_STATE_LOCKED	(1<<11)		/* card is currently locked */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -424,6 +425,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
+#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
+#define mmc_card_lockable(c)	((c)->csd.cmdclass & CCC_LOCK_CARD)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -437,6 +440,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
 #define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
+#define mmc_card_set_locked(c)	((c)->state |= MMC_STATE_LOCKED)
+#define mmc_card_clear_locked(c) ((c)->state &= ~MMC_STATE_LOCKED)
 
 /*
  * Quirk add/remove for MMC products.
-- 
1.8.1.3



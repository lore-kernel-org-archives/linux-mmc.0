From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 5/7] mmc: lock: Change SD init functionality to handle locked SD cards
Date: Wed, 5 Mar 2014 18:44:50 -0500
Message-ID: <1394063092-9048-6-git-send-email-alcooperx@gmail.com>
References: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:46172 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbaCEXxA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Mar 2014 18:53:00 -0500
In-Reply-To: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>

- Change mmc_sd_init_card() to check for a locked card and, if found,
try to get a password using the kernel KEYS subsystem, unlock the card
and continue. The unlock can fail due to a bad password, no password
or during boot when the rootfs that holds the password is not yet
available. To handle this, mmc_sd_init_card() will send just the early
init commands before trying to unlock and, on unlock failure, skip the
later init commands (which would fail on a locked card). mmc_sd_init_card()
will also handle the retry case, trigger via sysfs, where it will skip
the already issued early init commands, try again to unlock the card and
if successful issue the previously skipped later init commands.
These changes allow a card that failed unlock to still come up to the
point that the block device and sysfs for the device is created. This
allows the sysfs to be used to issue LOCK maintenance commands or to
trigger a retry, presumably after the password has be made available
by user space.

- Add sysfs attribute "unlock_retry" that will try again to unlock
and fully init the card.

- Add sysfs attribute "lock" to enable sysfs LOCK maintenance
commands

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/core.h  |   4 ++
 drivers/mmc/core/sd.c    | 138 ++++++++++++++++++++++++++++++++++-------------
 include/linux/mmc/card.h |   1 +
 3 files changed, 106 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 11a7e01..4a55cae 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -90,5 +90,9 @@ struct mmc_password {
 };
 int mmc_unlock_card(struct mmc_card *card);
 int mmc_get_password(struct mmc_card *card, struct mmc_password *password);
+ssize_t mmc_lock_show(struct device *dev, struct device_attribute *att,
+		      char *buf);
+ssize_t mmc_lock_store(struct device *dev, struct device_attribute *att,
+		       const char *data, size_t len);
 
 #endif
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 692fdb1..33398c9 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -27,6 +27,9 @@
 #include "sd.h"
 #include "sd_ops.h"
 
+static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
+			    struct mmc_card *oldcard);
+
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
 	0,		0,		0,		0
@@ -676,6 +679,39 @@ out:
 	return err;
 }
 
+#ifdef CONFIG_MMC_LOCK
+static ssize_t mmc_sd_unlock_retry_store(struct device *dev,
+					 struct device_attribute *att,
+					 const char *data, size_t len)
+{
+	int err;
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+	BUG_ON(!card);
+	BUG_ON(!host);
+
+	mmc_claim_host(host);
+	if (!mmc_card_locked(card)) {
+		mmc_release_host(host);
+		return len;
+	}
+	err = mmc_sd_init_card(host, card->ocr, card);
+	mmc_release_host(host);
+	if (err)
+		return err;
+	device_release_driver(dev);
+	err = device_attach(dev);
+	if (err < 0)
+		return err;
+	return len;
+}
+
+static DEVICE_ATTR(lock, S_IWUSR | S_IRUGO,
+		   mmc_lock_show, mmc_lock_store);
+static DEVICE_ATTR(unlock_retry, S_IWUSR,
+		   NULL, mmc_sd_unlock_retry_store);
+#endif /* CONFIG_MMC_LOCK */
+
 MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0], card->raw_cid[1],
 	card->raw_cid[2], card->raw_cid[3]);
 MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
@@ -705,6 +741,10 @@ static struct attribute *sd_std_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_serial.attr,
+#ifdef CONFIG_MMC_LOCK
+	&dev_attr_lock.attr,
+	&dev_attr_unlock_retry.attr,
+#endif /* CONFIG_MMC_LOCK */
 	NULL,
 };
 
@@ -924,56 +964,79 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr = 0;
+	u32 status;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
-	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
-	if (err)
-		return err;
-
-	if (oldcard) {
-		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
-			return -ENOENT;
-
+	/* Retry init of locked card */
+	if (oldcard && mmc_card_locked(oldcard)) {
 		card = oldcard;
+		oldcard = NULL;
+		rocr = card->raw_ocr;
 	} else {
-		/*
-		 * Allocate card structure.
-		 */
-		card = mmc_alloc_card(host, &sd_type);
-		if (IS_ERR(card))
-			return PTR_ERR(card);
+		err = mmc_sd_get_cid(host, ocr, cid, &rocr);
+		if (err)
+			return err;
+
+		if (oldcard) {
+			if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
+				return -ENOENT;
+
+			card = oldcard;
+		} else {
+			/*
+			 * Allocate card structure.
+			 */
+			card = mmc_alloc_card(host, &sd_type);
+			if (IS_ERR(card))
+				return PTR_ERR(card);
 
 		card->ocr = ocr;
-		card->type = MMC_TYPE_SD;
-		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
-	}
+			card->type = MMC_TYPE_SD;
+			memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
+		}
 
-	/*
-	 * For native busses:  get card RCA and quit open drain mode.
-	 */
-	if (!mmc_host_is_spi(host)) {
-		err = mmc_send_relative_addr(host, &card->rca);
-		if (err)
-			goto free_card;
-	}
+		/*
+		 * For native busses:  get card RCA and quit open drain mode.
+		 */
+		if (!mmc_host_is_spi(host)) {
+			err = mmc_send_relative_addr(host, &card->rca);
+			if (err)
+				goto free_card;
+		}
 
-	if (!oldcard) {
-		err = mmc_sd_get_csd(host, card);
-		if (err)
-			goto free_card;
+		if (!oldcard) {
+			err = mmc_sd_get_csd(host, card);
+			if (err)
+				goto free_card;
 
-		mmc_decode_cid(card);
+			mmc_decode_cid(card);
+		}
+
+		/*
+		 * Select card, as all following commands rely on that.
+		 */
+		if (!mmc_host_is_spi(host)) {
+			err = mmc_select_card(card);
+			if (err)
+				goto free_card;
+		}
 	}
 
-	/*
-	 * Select card, as all following commands rely on that.
-	 */
-	if (!mmc_host_is_spi(host)) {
-		err = mmc_select_card(card);
-		if (err)
-			goto free_card;
+	/* If card is locked, skip the rest of the init */
+	err = mmc_send_status(card, &status);
+	if (err)
+		goto free_card;
+	if (status & R1_CARD_IS_LOCKED) {
+		pr_info("%s: card is locked.\n", mmc_hostname(card->host));
+		err = mmc_unlock_card(card);
+		if (err != 0) {
+			pr_warn("%s: Card unlock failed.\n",
+				mmc_hostname(card->host));
+			card->raw_ocr = rocr;
+			goto locked_return;
+		}
 	}
 
 	err = mmc_sd_setup_card(host, card, oldcard != NULL);
@@ -1016,6 +1079,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+locked_return:
 	host->card = card;
 	return 0;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6846369..bd4b6b9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -285,6 +285,7 @@ struct mmc_card {
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
+	u32			raw_ocr;	/* raw card OCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
 	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card specific */
-- 
1.8.1.3


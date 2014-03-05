From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 7/7] mmc: lock: Change MMC init to handle locked cards.
Date: Wed, 5 Mar 2014 18:44:52 -0500
Message-ID: <1394063092-9048-8-git-send-email-alcooperx@gmail.com>
References: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:46172 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbaCEXxC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Mar 2014 18:53:02 -0500
In-Reply-To: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>

- Change mmc_init_card() to check for a locked card and, if found,
try to get a password using the kernel KEYS subsystem, unlock the card
and continue. Unlike SD cards, MMC cards support all initialization
commands when locked so the init sequence can be completed on a
locked card and the card can be used without further init after being
unlocked. If the unlock fails, the card state will be marked as "locked"
and the block layer will be prevented from coming up.

- Add sysfs attribute "unlock_retry" that will try again to unlock
the card. If the unlock succeeds, the cards "locked" state will be cleared
and the block layer will be allowed to come up.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/mmc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3703cd1..240ff48 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -726,10 +726,37 @@ out:
 		return res;
 }
 
-static DEVICE_ATTR(lock, S_IWUSR | S_IRUGO,
-		   mmc_lock_show, mmc_lock_store);
+static ssize_t mmc_unlock_retry_store(struct device *dev,
+				      struct device_attribute *att,
+				      const char *data, size_t len)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+	int err;
 
+	BUG_ON(!card);
+	BUG_ON(!host);
+
+	mmc_claim_host(host);
+	if (!mmc_card_locked(card)) {
+		mmc_release_host(host);
+		return len;
+	}
+	err = mmc_unlock_card(card);
+	mmc_release_host(host);
+	if (err < 0)
+		return err;
+	device_release_driver(dev);
+	err = device_attach(dev);
+	if (err < 0)
+		return err;
+	return len;
+}
 
+static DEVICE_ATTR(lock, S_IWUSR | S_IRUGO,
+		   mmc_lock_show, mmc_lock_store);
+static DEVICE_ATTR(unlock_retry, S_IWUSR,
+		   NULL, mmc_unlock_retry_store);
 #endif /* CONFIG_MMC_LOCK */
 
 
@@ -772,6 +799,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_rel_sectors.attr,
 #ifdef CONFIG_MMC_LOCK
 	&dev_attr_lock.attr,
+	&dev_attr_unlock_retry.attr,
 #endif /* CONFIG_MMC_LOCK */
 	NULL,
 };
@@ -958,6 +986,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	unsigned int max_dtr;
 	u32 rocr;
 	u8 *ext_csd = NULL;
+	u32 status;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -1413,6 +1442,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	/* If card is locked, try to unlock it */
+	err = mmc_send_status(card, &status);
+	if (err)
+		goto free_card;
+	if (status & R1_CARD_IS_LOCKED) {
+		pr_info("%s: card is locked.\n", mmc_hostname(card->host));
+		err = mmc_unlock_card(card);
+		if (err != 0) {
+			pr_warn("%s: Card unlock failed.\n",
+				mmc_hostname(card->host));
+		}
+	}
+
 	if (!oldcard)
 		host->card = card;
 
-- 
1.8.1.3


From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 7/8] mmc: lock: Change MMC init to handle locked cards.
Date: Fri, 5 Jun 2015 13:42:26 -0400
Message-ID: <1433526147-25941-8-git-send-email-alcooperx@gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:6749 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538AbbFESBY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 14:01:24 -0400
In-Reply-To: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, pgynther@google.com
Cc: Al Cooper <alcooperx@gmail.com>

- Change mmc_init_card() to check for a locked card and, if found,
try to get a password using the kernel KEYS subsystem, unlock the card
and continue. Unlike SD cards, MMC cards support all initialization
commands when locked so the init sequence can be completed on a
locked card and the card can be used without further init after being
unlocked. If the unlock fails, the card state will be marked as "locked"
which will prevent the block layer from reading the partition table.

- Add sysfs attribute "unlock_retry" that will try again to unlock
the card. If the unlock succeeds, the cards "locked" state will be cleared
and the block layer restarted which will now read the partition table.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/mmc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8e94eb8..2c953c5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -768,10 +768,37 @@ out:
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
+
+static DEVICE_ATTR(lock, S_IWUSR | S_IRUGO,
+		   mmc_lock_show, mmc_lock_store);
+static DEVICE_ATTR(unlock_retry, S_IWUSR,
+		   NULL, mmc_unlock_retry_store);
 #endif /* CONFIG_MMC_LOCK */
 
 
@@ -831,6 +858,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_rel_sectors.attr,
 #ifdef CONFIG_MMC_LOCK
 	&dev_attr_lock.attr,
+	&dev_attr_unlock_retry.attr,
 #endif /* CONFIG_MMC_LOCK */
 	NULL,
 };
@@ -1279,6 +1307,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr;
+	u32 status;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -1568,6 +1597,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
1.9.0.138.g2de3478


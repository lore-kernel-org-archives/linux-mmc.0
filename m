From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 3/7] mmc: lock: Add function to unlock a password locked card
Date: Wed, 5 Mar 2014 18:44:48 -0500
Message-ID: <1394063092-9048-4-git-send-email-alcooperx@gmail.com>
References: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:7333 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbaCEXw7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Mar 2014 18:52:59 -0500
In-Reply-To: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>

This function will try to get a password for the card and use the
password to unlock it. It will leave the card state flag set
appropriately.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8fc8c11..978e4e5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2793,6 +2793,27 @@ static inline void mmc_unregister_key_type(void)
 	unregister_key_type(&key_type_mmc);
 }
 
+int mmc_unlock_card(struct mmc_card *card)
+{
+	int stat;
+	struct mmc_password password;
+
+	mmc_card_set_locked(card);
+	stat = mmc_get_password(card, &password);
+	if (stat) {
+		pr_warn("%s: Cannot find matching key\n",
+			mmc_hostname(card->host));
+		return stat;
+	}
+	stat = mmc_lock_unlock(card, &password, MMC_LOCK_MODE_UNLOCK);
+	if (stat)
+		pr_warn("%s: Password failed to unlock card\n",
+			mmc_hostname(card->host));
+	else
+		mmc_card_clear_locked(card);
+	return stat;
+}
+
 #else /* CONFIG_MMC_LOCK */
 
 int mmc_get_password(struct mmc_card *card, struct mmc_password *password)
@@ -2809,6 +2830,11 @@ static inline void mmc_unregister_key_type(void)
 {
 }
 
+int mmc_unlock_card(struct mmc_card *card)
+{
+	return -ENOKEY;
+}
+
 #endif /* CONFIG_MMC_LOCK */
 
 static int __init mmc_init(void)
-- 
1.8.1.3


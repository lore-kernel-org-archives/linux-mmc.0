From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 3/8] mmc: lock: Add function to unlock a password locked card
Date: Fri, 5 Jun 2015 13:42:22 -0400
Message-ID: <1433526147-25941-4-git-send-email-alcooperx@gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:26579 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbFESBY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 14:01:24 -0400
In-Reply-To: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, pgynther@google.com
Cc: Al Cooper <alcooperx@gmail.com>

This function will try to get a password for the card and use the
password to unlock it. It will leave the card state flag set
appropriately.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4b0d26e..61f1f78 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2777,6 +2777,27 @@ static inline void mmc_unregister_key_type(void)
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
@@ -2793,6 +2814,11 @@ static inline void mmc_unregister_key_type(void)
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
1.9.0.138.g2de3478


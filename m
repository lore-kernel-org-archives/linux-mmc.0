From: "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH 3/7] mmc: lock: Add funtion to unlock a password locked
 card
Date: Tue, 13 Aug 2013 11:21:26 -0400
Message-ID: <1376407290-21477-4-git-send-email-alcooperx@gmail.com>
References: <1376407290-21477-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:2894 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757862Ab3HMPWT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Aug 2013 11:22:19 -0400
In-Reply-To: <1376407290-21477-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <acooper@broadcom.com>

From: Al Cooper <acooper@broadcom.com>

This function will try to get a password for the card and use the
password to unlock it. It will leave the card state flag set
appropriately.

refs #SWLINUX-2545

Signed-off-by: Al Cooper <acooper@broadcom.com>
---
 drivers/mmc/core/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 510927f..7dd6a33 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2776,6 +2776,34 @@ struct key_type mmc_key_type = {
 	.match		= mmc_key_match,
 	.destroy	= mmc_key_destroy,
 };
+
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
+		pr_warn("%s: Wrong password\n", mmc_hostname(card->host));
+	else
+		mmc_card_clear_locked(card);
+	return stat;
+}
+
+#else /* CONFIG_MMC_LOCK */
+
+int mmc_unlock_card(struct mmc_card *card)
+{
+	return -ENOKEY;
+}
+
 #endif /* CONFIG_MMC_LOCK */
 
 static int __init mmc_init(void)
-- 
1.8.1.3



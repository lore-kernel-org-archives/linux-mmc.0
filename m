From: Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH] mmc: core: add error message when switching fails in
 mmc_select_hs()
Date: Tue, 23 Aug 2016 17:06:53 +0900
Message-ID: <1471939613-5775-1-git-send-email-js07.lee@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:9209 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756725AbcHWIIA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2016 04:08:00 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OCC00BY8RXAA510@mailout4.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 23 Aug 2016 09:07:58 +0100 (BST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jungseung Lee <js07.lee@samsung.com>

The switch failure message in mmc_select_timing had been removed
since that is invalid: commit 0400ed0a083a ("mmc: core: remove the
invalid message in mmc_select_timing")

Now, in the case when mmc_select_hs return error in mmc_select_timing,
there is nothing to print failure message.
Let's make for mmc_select_hs() print message itself in the failure case.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 drivers/mmc/core/mmc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f2d185c..d2367f8 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1018,6 +1018,7 @@ static int mmc_switch_status(struct mmc_card *card)
  */
 static int mmc_select_hs(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	int err;
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1027,6 +1028,9 @@ static int mmc_select_hs(struct mmc_card *card)
 	if (!err) {
 		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 		err = mmc_switch_status(card);
+	} else {
+		pr_err("%s: switch to high-speed failed, err:%d\n",
+			mmc_hostname(host), err);
 	}
 
 	return err;
@@ -1265,11 +1269,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
 
 	/* Switch card to HS mode */
 	err = mmc_select_hs(card);
-	if (err) {
-		pr_err("%s: switch to high-speed failed, err:%d\n",
-			mmc_hostname(host), err);
+	if (err)
 		goto out_err;
-	}
 
 	err = mmc_switch_status(card);
 	if (err)
-- 
1.7.9.5


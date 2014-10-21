From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 13/15] mmc: core: Remove the redundant mmc_send_ext_csd() API
Date: Tue, 21 Oct 2014 19:19:11 +0200
Message-ID: <1413911953-19012-14-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:41889 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbaJURTo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:44 -0400
Received: by mail-la0-f49.google.com with SMTP id q1so1444808lam.36
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:42 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Previous patches has replaced the calls to mmc_send_ext_csd() into
mmc_get_ext_csd(), thus mmc_send_ext_csd() has become redundant. Let's
remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 10 ++--------
 include/linux/mmc/core.h   |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 72e1f9b..9a6181b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -378,13 +378,6 @@ err:
 	return ret;
 }
 
-int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
-{
-	return mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD,
-			ext_csd, 512);
-}
-EXPORT_SYMBOL_GPL(mmc_send_ext_csd);
-
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 {
 	int err;
@@ -404,7 +397,8 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	if (!ext_csd)
 		return -ENOMEM;
 
-	err = mmc_send_ext_csd(card, ext_csd);
+	err = mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD, ext_csd,
+				512);
 	if (err)
 		kfree(ext_csd);
 	else
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 0a77d35..b11e43c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -154,7 +154,6 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
 			bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
-extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 
 #define MMC_ERASE_ARG		0x00000000
-- 
1.9.1


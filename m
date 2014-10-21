From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/15] mmc: core: Remove mmc_free_ext_csd()
Date: Tue, 21 Oct 2014 19:18:59 +0200
Message-ID: <1413911953-19012-2-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:51387 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbaJURTV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:21 -0400
Received: by mail-la0-f49.google.com with SMTP id q1so1421489lam.22
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:20 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Let callers of mmc_free_ext_csd() do kfree() directly instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a301a78..87ee28f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -632,12 +632,6 @@ out:
 	return err;
 }
 
-static inline void mmc_free_ext_csd(u8 *ext_csd)
-{
-	kfree(ext_csd);
-}
-
-
 static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 {
 	u8 *bw_ext_csd;
@@ -711,7 +705,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 		err = -EINVAL;
 
 out:
-	mmc_free_ext_csd(bw_ext_csd);
+	kfree(bw_ext_csd);
 	return err;
 }
 
@@ -1545,14 +1539,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!oldcard)
 		host->card = card;
 
-	mmc_free_ext_csd(ext_csd);
+	kfree(ext_csd);
 	return 0;
 
 free_card:
 	if (!oldcard)
 		mmc_remove_card(card);
 err:
-	mmc_free_ext_csd(ext_csd);
+	kfree(ext_csd);
 
 	return err;
 }
-- 
1.9.1


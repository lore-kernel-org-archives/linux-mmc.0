From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH] mmc: core: Update the ext-csd.rev check for eMMC5.1
Date: Tue, 21 May 2013 15:08:43 +0530
Message-ID: <1369129124-31128-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50915 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab3EUJjD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 May 2013 05:39:03 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so515886pab.27
        for <linux-mmc@vger.kernel.org>; Tue, 21 May 2013 02:39:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Alim Akhtar <alim.akthar@samsung.com>

With the new eMMC5.1 spec,there is a new EXT_CSD register with
the revision number(EXT_CSD_REV) 7.This patch updates the check
for ext-csd.rev number as 7.

Signed-off-by: Alim Akhtar <alim.akthar@samsung.com>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0cbd1ef..73f58e0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -293,7 +293,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 
 	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
-	if (card->ext_csd.rev > 6) {
+	if (card->ext_csd.rev > 7) {
 		pr_err("%s: unrecognised EXT_CSD revision %d\n",
 			mmc_hostname(card->host), card->ext_csd.rev);
 		err = -EINVAL;
-- 
1.7.9.5


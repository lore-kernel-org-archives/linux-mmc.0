From: Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH 1/3] mmc: sd: Remove superfluous error code assignment
Date: Thu, 10 Sep 2015 00:33:16 +0800
Message-ID: <1441816398-4330-1-git-send-email-yszhou4tech@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36215 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbbIIQhe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2015 12:37:34 -0400
Received: by padhk3 with SMTP id hk3so14874172pad.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2015 09:37:33 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, Yousong Zhou <yszhou4tech@gmail.com>

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 drivers/mmc/core/sd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4e7366a..e28ebf3 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -357,8 +357,6 @@ int mmc_sd_switch_hs(struct mmc_card *card)
 	if (card->sw_caps.hs_max_dtr == 0)
 		return 0;
 
-	err = -EIO;
-
 	status = kmalloc(64, GFP_KERNEL);
 	if (!status) {
 		pr_err("%s: could not allocate a buffer for "
-- 
1.7.10.4


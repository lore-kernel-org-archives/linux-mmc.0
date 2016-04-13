From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 5/6] mmc: ffu: Hack for Hynix eMMC
Date: Wed, 13 Apr 2016 15:33:43 -0700
Message-ID: <1460586824-40688-6-git-send-email-gwendal@chromium.org>
References: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32936 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbcDMWec (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 18:34:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id 184so39416925pff.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 15:34:32 -0700 (PDT)
In-Reply-To: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, Alex.Lemberg@sandisk.com, avi.shchislowski@sandisk.com, yaniv.agman@sandisk.com, holgerschurig@gmail.com, chris@printf.net, baolin.wang@linaro.org
Cc: linux-mmc@vger.kernel.org

When sending the switch command to Hynix eMMC HBG4e requires
the cmd bits should be set to 0, even if they should not have been
looked by the devices when writing a byte of the ext csd.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/ffu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/ffu.c b/drivers/mmc/core/ffu.c
index c2883a8..8538365 100644
--- a/drivers/mmc/core/ffu.c
+++ b/drivers/mmc/core/ffu.c
@@ -274,7 +274,7 @@ static int mmc_ffu_switch_mode(struct mmc_card *card, int mode)
 	}
 
 	if (!err) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+		err = mmc_switch(card, 0,
 			offset, mode,
 			card->ext_csd.generic_cmd6_time);
 	}
-- 
2.8.0.rc3.226.g39d4020


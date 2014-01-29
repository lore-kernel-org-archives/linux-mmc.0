From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/13] mmc: core: Use generic CMD6 time while switching to eMMC HS200 mode
Date: Wed, 29 Jan 2014 23:37:58 +0100
Message-ID: <1391035085-2747-7-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:46823 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaA2WiZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:25 -0500
Received: by mail-la0-f42.google.com with SMTP id hr13so2025193lab.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:23 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Conform to the eMMC spec and use the CMD6 generic timeout from the
EXT_CSD register, when switching to HS200 mode.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ae3489a..897fdd1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -857,7 +857,9 @@ static int mmc_select_hs200(struct mmc_card *card)
 	/* switch to HS200 mode if bus width set successfully */
 	if (!err)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_HS_TIMING, 2, 0, true, true, true);
+				EXT_CSD_HS_TIMING, 2,
+				card->ext_csd.generic_cmd6_time,
+				true, true, true);
 err:
 	return err;
 }
-- 
1.7.9.5


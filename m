From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/10] mmc: core: Use generic CMD6 time while switching to eMMC HS200 mode
Date: Wed, 22 Jan 2014 16:00:19 +0100
Message-ID: <1390402824-9850-6-git-send-email-ulf.hansson@linaro.org>
References: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41112 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaAVPAi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 10:00:38 -0500
Received: by mail-wi0-f174.google.com with SMTP id g10so5713021wiw.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2014 07:00:37 -0800 (PST)
In-Reply-To: <1390402824-9850-1-git-send-email-ulf.hansson@linaro.org>
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


From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 2/3] mmc: core: remove the invalid message in mmc_select_timing
Date: Thu, 21 Apr 2016 00:51:31 +0800
Message-ID: <1461171092-30631-2-git-send-email-aisheng.dong@nxp.com>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0083.outbound.protection.outlook.com ([65.55.169.83]:35136
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751231AbcDTQ7H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 12:59:07 -0400
In-Reply-To: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, haibo.chen@nxp.com, dongas86@gmail.com

mmc_select_hs200() and mmc_select_hs() will keep the timing
as before if switch fails. So it's meaningless to print the
failed switched mode outside based on the current host timing.

Furthermore, the original print is wrong, it should be:
pr_warn("%s: switch to %s failed\n",
	mmc_hostname(card->host),
	mmc_card_hs(card) ? "high-speed" :
	(mmc_card_hs200(card) ? "hs200" : ""));

Since we already have error message in mmc_select_hs200(),
simply remove it outside.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/core/mmc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f6683a9..55c8201 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1321,21 +1321,13 @@ static int mmc_select_timing(struct mmc_card *card)
 	if (err && err != -EBADMSG)
 		return err;
 
-	if (err) {
-		pr_warn("%s: switch to %s failed\n",
-			mmc_card_hs(card) ? "high-speed" :
-			(mmc_card_hs200(card) ? "hs200" : ""),
-			mmc_hostname(card->host));
-		err = 0;
-	}
-
 bus_speed:
 	/*
 	 * Set the bus speed to the selected bus timing.
 	 * If timing is not selected, backward compatible is the default.
 	 */
 	mmc_set_bus_speed(card);
-	return err;
+	return 0;
 }
 
 /*
-- 
1.9.1


From: Balaji T K <balajitk@ti.com>
Subject: [RFC/RFT] MMC: CORE: eMMC in Sleep mode before suspend
Date: Wed, 13 Jul 2011 20:06:27 +0530
Message-ID: <1310567787-14697-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46347 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1GMOhS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 10:37:18 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6DEbE5t002797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2011 09:37:17 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6DEbE60008630
	for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2011 20:07:14 +0530 (IST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Balaji T K <balajitk@ti.com>

Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
in the mmc suspend to minimize power consumption.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/core/mmc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index afabdc3..e8dfcde 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -900,16 +900,20 @@ static void mmc_detect(struct mmc_host *host)
  */
 static int mmc_suspend(struct mmc_host *host)
 {
+	int err = 0;
+
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	if (!mmc_host_is_spi(host))
+	if (mmc_card_can_sleep(host))
+		err = mmc_card_sleep(host);
+	else if (!mmc_host_is_spi(host))
 		mmc_deselect_cards(host);
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_release_host(host);
 
-	return 0;
+	return err;
 }
 
 /*
-- 
1.7.0.4


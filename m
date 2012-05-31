From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: fix wrong return value when suspend
Date: Thu, 31 May 2012 20:31:47 +0900
Message-ID: <4FC756A3.3000803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53500 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab2EaLby (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 May 2012 07:31:54 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4V000WFXD455R0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 May 2012 20:31:52 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M4V005KOXD3VY40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 31 May 2012 20:31:52 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

When mmc_host is not spi mode, mmc/sd is doing mmc_deselect_cards().
mmc_deselect_cards could be returned error.
If returned error, we can know something wrong when enter suspend.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/mmc.c |    2 +-
 drivers/mmc/core/sd.c  |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2d4a4b7..258b203 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1326,7 +1326,7 @@ static int mmc_suspend(struct mmc_host *host)
 		if (!err)
 			mmc_card_set_sleep(host->card);
 	} else if (!mmc_host_is_spi(host))
-		mmc_deselect_cards(host);
+		err = mmc_deselect_cards(host);
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 	mmc_release_host(host);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c272c686..b2b43f6 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1075,16 +1075,18 @@ static void mmc_sd_detect(struct mmc_host *host)
  */
 static int mmc_sd_suspend(struct mmc_host *host)
 {
+	int err = 0;
+
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
 	if (!mmc_host_is_spi(host))
-		mmc_deselect_cards(host);
+		err = mmc_deselect_cards(host);
 	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_release_host(host);
 
-	return 0;
+	return err;
 }
 
 /*

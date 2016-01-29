From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 01/12] mmc: core: use the defined function to check whether
 card is removable
Date: Fri, 29 Jan 2016 13:06:00 +0900
Message-ID: <1454040371-31625-2-git-send-email-jh80.chung@samsung.com>
References: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50318 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbcA2EGT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 23:06:19 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P01O734QHD000@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 13:06:17 +0900 (KST)
In-reply-to: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

In linux/mmc/host.h, mmc_card_is_removable() is already defined.
There is no reason that it doesn't use.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f95d41f..9da9b60 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2532,7 +2532,7 @@ int mmc_detect_card_removed(struct mmc_host *host)
 	if (!card)
 		return 1;
 
-	if (host->caps & MMC_CAP_NONREMOVABLE)
+	if (!mmc_card_is_removable(host))
 		return 0;
 
 	ret = mmc_card_removed(card);
@@ -2570,7 +2570,7 @@ void mmc_rescan(struct work_struct *work)
 		return;
 
 	/* If there is a non-removable card registered, only scan once */
-	if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered)
+	if (!mmc_card_is_removable(host) && host->rescan_entered)
 		return;
 	host->rescan_entered = 1;
 
@@ -2587,8 +2587,7 @@ void mmc_rescan(struct work_struct *work)
 	 * if there is a _removable_ card registered, check whether it is
 	 * still present
 	 */
-	if (host->bus_ops && !host->bus_dead
-	    && !(host->caps & MMC_CAP_NONREMOVABLE))
+	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
@@ -2613,7 +2612,7 @@ void mmc_rescan(struct work_struct *work)
 	mmc_bus_put(host);
 
 	mmc_claim_host(host);
-	if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
+	if (mmc_card_is_removable(host) && host->ops->get_cd &&
 			host->ops->get_cd(host) == 0) {
 		mmc_power_off(host);
 		mmc_release_host(host);
-- 
1.9.1


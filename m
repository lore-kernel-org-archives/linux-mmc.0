From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: convert all pr_* to dev_*
Date: Thu, 23 Feb 2012 17:02:20 +0530
Message-ID: <1329996740-26966-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42146 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab2BWLca (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Feb 2012 06:32:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Convert all instances of pr_* prints within the driver
to instead use dev_* prints.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
Re-sending as this patch did not make it to the lists due to
issues with my 'git send-email'

 drivers/mmc/host/omap_hsmmc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e3eb9d4..35f6dc1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -302,7 +302,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 			mmc_slot(host).ocr_mask = ocr_value;
 		} else {
 			if (!(mmc_slot(host).ocr_mask & ocr_value)) {
-				pr_err("MMC ocrmask %x is not supported\n",
+				dev_err(host->dev, "ocrmask %x is not supported\n",
 					mmc_slot(host).ocr_mask);
 				mmc_slot(host).ocr_mask = 0;
 				return -EINVAL;
@@ -1132,14 +1132,14 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 	host->reqs_blocked = 0;
 	if (mmc_slot(host).get_cover_state(host->dev, host->slot_id)) {
 		if (host->protect_card) {
-			pr_info("%s: cover is closed, "
+			dev_info(host->dev, "%s: cover is closed, "
 					 "card is now accessible\n",
 					 mmc_hostname(host->mmc));
 			host->protect_card = 0;
 		}
 	} else {
 		if (!host->protect_card) {
-			pr_info("%s: cover is open, "
+			dev_info(host->dev, "%s: cover is open, "
 					 "card is now inaccessible\n",
 					 mmc_hostname(host->mmc));
 			host->protect_card = 1;
@@ -1276,7 +1276,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 
 	if (!next && data->host_cookie &&
 	    data->host_cookie != host->next_data.cookie) {
-		pr_warning("[%s] invalid cookie: data->host_cookie %d"
+		dev_warn(host->dev, "[%s] invalid cookie: data->host_cookie %d"
 		       " host->next_data.cookie %d\n",
 		       __func__, data->host_cookie, host->next_data.cookie);
 		data->host_cookie = 0;
-- 
1.7.1


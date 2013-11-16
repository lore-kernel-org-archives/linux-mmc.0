From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 1/8] mmc: omap: Fix NULL pointer dereference due uninitialized cover_tasklet
Date: Sat, 16 Nov 2013 17:53:07 +0200
Message-ID: <1384617194-22126-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:47019 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162Ab3KPPxk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Nov 2013 10:53:40 -0500
In-Reply-To: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Omap MMC driver initialization can cause a NULL pointer dereference in
tasklet_hi_action on Nokia N810 if its miniSD cover is open during driver
initialization.

Reason for this is that omap_notify_cover_event which calls
tasklet_hi_schedule gets called before struct cover_tasklet is initialized.

Call to omap_notify_cover_event on Nokia N810 happens from menelaus.c PMIC
driver via board-n8x0.c during execution of mmc_add_host in case of open
miniSD cover.

Fix this by moving cover_timer and cover_tasklet initialization before
mmc_add_host call in mmc_omap_new_slot.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0b10a90..df2d10f 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1272,6 +1272,13 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
+	if (slot->pdata->get_cover_state != NULL) {
+		setup_timer(&slot->cover_timer, mmc_omap_cover_timer,
+			    (unsigned long)slot);
+		tasklet_init(&slot->cover_tasklet, mmc_omap_cover_handler,
+			     (unsigned long)slot);
+	}
+
 	r = mmc_add_host(mmc);
 	if (r < 0)
 		goto err_remove_host;
@@ -1288,11 +1295,6 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 					&dev_attr_cover_switch);
 		if (r < 0)
 			goto err_remove_slot_name;
-
-		setup_timer(&slot->cover_timer, mmc_omap_cover_timer,
-			    (unsigned long)slot);
-		tasklet_init(&slot->cover_tasklet, mmc_omap_cover_handler,
-			     (unsigned long)slot);
 		tasklet_schedule(&slot->cover_tasklet);
 	}
 
-- 
1.8.4.2


From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH FIX+RESEND 1/7] mmc: omap: Fix NULL pointer dereference due uninitialized cover_tasklet
Date: Sun,  6 Oct 2013 20:36:12 +0300
Message-ID: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46788 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab3JFRih (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Oct 2013 13:38:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, aaro.koskinen@iki.fi, Jarkko Nikula <jarkko.nikula@bitmer.com>

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
index b94f38e..31f33ac 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1273,6 +1273,13 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
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
@@ -1289,11 +1296,6 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
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
1.8.4.rc3


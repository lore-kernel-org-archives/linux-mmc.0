From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] sdio: Fix crash in mmc_attach_sdio() error path
Date: Tue,  1 Dec 2009 15:13:00 +0000 (GMT)
Message-ID: <20091201151300.A34C29D404F@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:55807 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462AbZLAP1d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 10:27:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org, matt@console-pimps.org

At http://dev.laptop.org/ticket/9707 we are seeing a crash in
the error path of mmc_attach_sdio()

BUG: unable to handle kernel paging request at 6b6b6c57
IP: [<b066d6e2>] sdio_remove_func+0x9/0x27
Call Trace:
[<b066cfb4>] ? mmc_sdio_remove+0x34/0x65
[<b066d1fc>] ? mmc_attach_sdio+0x217/0x240
[<b066a22f>] ? mmc_rescan+0x1a2/0x20f
[<b042e9a0>] ? worker_thread+0x156/0x1e1

Matt Fleming pointed out that this is because more cards are being
removed than have been initialized/added in the error path.

Fix the error path to handle failures gracefully. Based on earlier
patch from Matt.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/sdio.c     |    6 ++++--
 drivers/mmc/core/sdio_bus.c |    7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index cdb845b..fa07d4f 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -516,7 +516,8 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	 * The number of functions on the card is encoded inside
 	 * the ocr.
 	 */
-	card->sdio_funcs = funcs = (ocr & 0x70000000) >> 28;
+	funcs = (ocr & 0x70000000) >> 28;
+	card->sdio_funcs = 0;
 
 	/*
 	 * If needed, disconnect card detection pull-up resistor.
@@ -528,10 +529,11 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	/*
 	 * Initialize (but don't add) all present functions.
 	 */
-	for (i = 0;i < funcs;i++) {
+	for (i = 0;i < funcs;i++, card->sdio_funcs++) {
 		err = sdio_init_func(host->card, i + 1);
 		if (err)
 			goto remove;
+		card->sdio_funcs = i + 1;
 	}
 
 	mmc_release_host(host);
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d37464e..9e060c8 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -248,12 +248,15 @@ int sdio_add_func(struct sdio_func *func)
 /*
  * Unregister a SDIO function with the driver model, and
  * (eventually) free it.
+ * This function can be called through error paths where sdio_add_func() was
+ * never executed (because a failure occurred at an earlier point).
  */
 void sdio_remove_func(struct sdio_func *func)
 {
-	if (sdio_func_present(func))
-		device_del(&func->dev);
+	if (!sdio_func_present(func))
+		return;
 
+	device_del(&func->dev);
 	put_device(&func->dev);
 }
 
-- 
1.6.2.5


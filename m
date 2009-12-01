From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH] sdio: Initialise SDIO functions and update card->sdio_funcs in lockstep
Date: Tue,  1 Dec 2009 14:50:56 +0000
Message-ID: <1259679056-10343-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:41677 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZLAOtK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 09:49:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>

We need to accurately track how many SDIO functions have been
initialised (and keep card->sdio_funcs in sync) so that we don't try to
remove more functions than we initialised if we hit the error path in
mmc_attach_sdio().

Without this patch if we hit the error path in mmc_attach_sdio() we run
the risk of deferencing invalid memory in sdio_remove_func(), leading to
a crash.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/core/sdio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index cdb845b..8002797 100644
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
@@ -528,7 +529,7 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	/*
 	 * Initialize (but don't add) all present functions.
 	 */
-	for (i = 0;i < funcs;i++) {
+	for (i = 0;i < funcs;i++, card->sdio_funcs++) {
 		err = sdio_init_func(host->card, i + 1);
 		if (err)
 			goto remove;
-- 
1.6.4.rc0


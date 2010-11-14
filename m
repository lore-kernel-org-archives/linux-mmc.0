From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] sdio: fix nasty oops in mmc_sdio_detect
Date: Sun, 14 Nov 2010 12:40:33 +0200
Message-ID: <1289731233-19996-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37691 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab0KNKkN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Nov 2010 05:40:13 -0500
Received: by wwb29 with SMTP id 29so362707wwb.1
        for <linux-mmc@vger.kernel.org>; Sun, 14 Nov 2010 02:40:12 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Power off the card in mmc_sdio_detect __before__ a potential error
handler, which completely removes the card, executes, and only if the
card was successfully powered on beforehand.

While we're at it, use the _sync variant of the runtime PM put API, in
order to ensure that the card is left powered off in case an error
occurred, and the card is going to be removed.

Reproduced and tested on the XO-1.5.

Reported-by: Daniel Drake <dsd@laptop.org>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c3ad105..42a949b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -560,6 +560,19 @@ static void mmc_sdio_detect(struct mmc_host *host)
 
 	mmc_release_host(host);
 
+	/*
+	 * Tell PM core it's OK to power off the card now.
+	 *
+	 * The _sync variant is used in order to ensure that the card
+	 * is left powered off in case an error occurred, and the card
+	 * is going to be removed.
+	 *
+	 * Since there is no specific reason to believe a new user
+	 * is about to show up at this point, the _sync variant is
+	 * desirable anyway.
+	 */
+	pm_runtime_put_sync(&host->card->dev);
+
 out:
 	if (err) {
 		mmc_sdio_remove(host);
@@ -568,9 +581,6 @@ out:
 		mmc_detach_bus(host);
 		mmc_release_host(host);
 	}
-
-	/* Tell PM core that we're done */
-	pm_runtime_put(&host->card->dev);
 }
 
 /*
-- 
1.7.0.4


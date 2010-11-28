From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan
Date: Sun, 28 Nov 2010 07:21:28 +0200
Message-ID: <1290921690-6133-2-git-send-email-ohad@wizery.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57371 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0K1FTo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 00:19:44 -0500
Received: by mail-fx0-f46.google.com with SMTP id 15so1617040fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 27 Nov 2010 21:19:43 -0800 (PST)
In-Reply-To: <1290921690-6133-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

mmc_rescan checks whether registered cards are still present before
skipping them, by calling the bus-specific ->detect() handler.

With buses that support runtime PM, the card may be powered off at
this point, so they need to be powered on and fully reinitialized before
->detect() executes.

This whole process is redundant with nonremovable cards; in those cases,
we can safely skip calling ->detect() and implicitly assume its success.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6286898..e8332d7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1506,8 +1506,12 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
-	/* if there is a card registered, check whether it is still present */
-	if ((host->bus_ops != NULL) && host->bus_ops->detect && !host->bus_dead)
+	/*
+	 * if there is a _removable_ card registered, check whether it is
+	 * still present
+	 */
+	if ((host->bus_ops != NULL) && host->bus_ops->detect && !host->bus_dead
+					&& mmc_card_is_removable(host))
 		host->bus_ops->detect(host);
 
 	mmc_bus_put(host);
-- 
1.7.0.4


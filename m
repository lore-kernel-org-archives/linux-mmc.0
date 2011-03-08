From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] mmc: fix CONFIG_MMC_UNSAFE_RESUME regression
Date: Tue,  8 Mar 2011 23:32:02 +0200
Message-ID: <1299619922-22220-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53272 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949Ab1CHVcF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 16:32:05 -0500
Received: by wya21 with SMTP id 21so393148wya.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 13:32:04 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Dmitry Shmidt <dimitrysh@google.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, stable@kernel.org

30201e7 allowed skipping detection of nonremovable cards on
mmc_rescan(). The intention was to only skip detection of hardwired
cards that cannot be removed, so make sure this is indeed the
case by directly checking for (lack of) MMC_CAP_NONREMOVABLE, instead
of using mmc_card_is_removable(), which is overloaded with
CONFIG_MMC_UNSAFE_RESUME semantics.

Reported-and-tested-by: Dmitry Shmidt <dimitrysh@google.com>
Reported-and-tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: <stable@kernel.org>
---
Based on linux-2.6.git master, as this should probably go to Linus.

 drivers/mmc/core/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6625c05..150b5f3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1529,7 +1529,7 @@ void mmc_rescan(struct work_struct *work)
 	 * still present
 	 */
 	if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
-	    && mmc_card_is_removable(host))
+	    && !(host->caps & MMC_CAP_NONREMOVABLE))
 		host->bus_ops->detect(host);
 
 	/*
-- 
1.7.1


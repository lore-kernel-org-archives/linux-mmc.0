From: Arend van Spriel <arend@broadcom.com>
Subject: [PATCH V3] sdhci: only reprogram retuning timer when flag is set
Date: Sat, 4 Jan 2014 13:51:26 +0100
Message-ID: <1388839886-18657-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:34456 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbaADMv3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Jan 2014 07:51:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Arend van Spriel <arend@broadcom.com>

When the host->tuning_count is zero it means that the
retuning is disabled. This is checked on the first
run of sdhci_execute_tuning() by the if statement below:

	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {

So only when tuning_count is non-zero it will set the host
flag SDHCI_USING_RETUNING_TIMER. The else statement is only
for re-programming the timer, which means that flag must be
set. Because that is not checked the else statement is executed
in the first run when tuning_count is zero.

This was seen on a host controller which indicated
SDHCI_TUNING_MODE_1 (0) and tuning_count being zero. Suspect
that (one of) these registers is not properly set.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
It has been a while looking at this, but I believe I never sent
a V3 of this patch so here it is. This patch applies to the
mmc-next branch.

V3:
- remote tuning mode check for retuning timer reload

V2:
- add more explanation to the commit message
- check host flag SDHCI_USING_RETUNING_TIMER
---
 drivers/mmc/host/sdhci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cc00bed..058b7de 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2026,12 +2026,11 @@ out:
 			host->tuning_count * HZ);
 		/* Tuning mode 1 limits the maximum data length to 4MB */
 		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
-	} else {
+	} else if (host->flags & SDHCI_USING_RETUNING_TIMER) {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		/* Reload the new initial value for timer */
-		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
-			mod_timer(&host->tuning_timer, jiffies +
-				host->tuning_count * HZ);
+		mod_timer(&host->tuning_timer, jiffies +
+			  host->tuning_count * HZ);
 	}
 
 	/*
-- 
1.8.1.3


From: Arend van Spriel <arend@broadcom.com>
Subject: RESEND:[PATCH V3] sdhci: only reprogram retuning timer when flag is set
Date: Fri, 21 Feb 2014 20:59:42 +0100
Message-ID: <1393012782-23917-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:31468 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbaBUT7r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2014 14:59:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Arend van Spriel <arend@broadcom.com>, Dong Aisheng <dongas86@gmail.com>, Aaron Lu <aaron.lwe@gmail.com>

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

Cc: Dong Aisheng <dongas86@gmail.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
Noticed this patch was still not applied so please reconsider
taking it in and let me know. The patch has been rebased and
applies to the mmc-next branch.

Regards,
Arend

V3:
- remote tuning mode check for retuning timer reload

V2:
- add more explanation to the commit message
- check host flag SDHCI_USING_RETUNING_TIMER
---
 drivers/mmc/host/sdhci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ddef47..d5b421d 100644
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


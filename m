From: "Arend van Spriel" <arend@broadcom.com>
Subject: [PATCH V2] sdhci: only reprogram retuning timer when flag is
 set
Date: Mon, 11 Nov 2013 10:49:55 +0100
Message-ID: <1384163395-27038-1-git-send-email-arend@broadcom.com>
References: <1383821960-2533-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:3408 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab3KKJuN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Nov 2013 04:50:13 -0500
In-Reply-To: <1383821960-2533-1-git-send-email-arend@broadcom.com>
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
This patch applies to the mmc-next branch.

V2:
- add more explanation to the commit message
- check host flag SDHCI_USING_RETUNING_TIMER
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bd8a098..5974599 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2014,7 +2014,7 @@ out:
 			host->tuning_count * HZ);
 		/* Tuning mode 1 limits the maximum data length to 4MB */
 		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
-	} else {
+	} else if (host->flags & SDHCI_USING_RETUNING_TIMER) {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		/* Reload the new initial value for timer */
 		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
-- 
1.7.10.4



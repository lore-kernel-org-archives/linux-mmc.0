From: "Arend van Spriel" <arend@broadcom.com>
Subject: [PATCH] sdhci: do not program timer when tuning_count is zero
Date: Thu, 7 Nov 2013 11:59:19 +0100
Message-ID: <1383821960-2533-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:4359 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab3KGK7e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Nov 2013 05:59:34 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Arend van Spriel <arend@broadcom.com>

When the host->tuning_count is zero it means that the
retuning is disabled. Doing a mod_timer() with a zero
tuning_count does something else.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a7fb4f..9803e7a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2007,7 +2007,8 @@ out:
 	} else {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		/* Reload the new initial value for timer */
-		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+		if (host->tuning_count &&
+		    host->tuning_mode == SDHCI_TUNING_MODE_1)
 			mod_timer(&host->tuning_timer, jiffies +
 				host->tuning_count * HZ);
 	}
-- 
1.7.10.4



From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] sdhci: Always pass clock request value zero to set_clock host op
Date: Fri,  9 Dec 2011 13:34:11 +0200
Message-ID: <1323430451-14701-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45654 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab1LILeZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Dec 2011 06:34:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Todd Poynor <toddpoynor@google.com>

From: Todd Poynor <toddpoynor@google.com>

To allow the set_clock host op to disable the SDCLK source when not
needed, always call the host op when the requested clock speed is
zero.  Do this even if host->clock already equals zero, because
the SDHCI driver may set that value (without calling the host op)
to force an update at the next (non-zero-speed) call.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ab6018f..92332a1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1070,7 +1070,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk = 0;
 	unsigned long timeout;
 
-	if (clock == host->clock)
+	if (clock && clock == host->clock)
 		return;
 
 	host->mmc->actual_clock = 0;
-- 
1.7.6.4


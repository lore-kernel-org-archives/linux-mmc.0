From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: core: make erase timeout calculation allow for gated clock
Date: Thu, 23 Jun 2011 13:40:27 +0300
Message-ID: <1308825629-27375-3-git-send-email-adrian.hunter@intel.com>
References: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21043 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759157Ab1FWKlQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2011 06:41:16 -0400
In-Reply-To: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

The erase timeout calculation may depend on clock rate
which is zero if the clock is gated, so use
mmc_host_clk_rate() which allows for that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 68091dd..7843efe 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1245,7 +1245,7 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 		 */
 		timeout_clks <<= 1;
 		timeout_us += (timeout_clks * 1000) /
-			      (card->host->ios.clock / 1000);
+			      (mmc_host_clk_rate(card->host) / 1000);
 
 		erase_timeout = timeout_us / 1000;
 
-- 
1.7.4.4


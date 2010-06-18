From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: change initial clock setting
Date: Fri, 18 Jun 2010 13:05:44 +0900
Message-ID: <4C1AF098.1080400@samsung.com>
Reply-To: jh80.chung@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16302 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0FREFq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2010 00:05:46 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4600E5XZDKE6A0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Jun 2010 13:05:44 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4600FUZZDK0R@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Jun 2010 13:05:44 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org

This patch is bug fixed..
I think that host->ios.clock(initial clock) will be set lower than 400KHz.
But in this code, if host->f_min is higher than 400KHz, print warning message and set higher than 400KHz.
And We use SDHCI_QUIRK_NONSTANDARD_CLOCK..so using get_min_clock function. 
but didn't effect nothing through used get_min_clock function.


 Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 569e94d..9cd5767 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -910,9 +910,9 @@ static void mmc_power_up(struct mmc_host *host)
 	if (host->f_min > 400000) {
 		pr_warning("%s: Minimum clock frequency too high for "
 				"identification mode\n", mmc_hostname(host));
-		host->ios.clock = host->f_min;
-	} else
 		host->ios.clock = 400000;
+	} else
+		host->ios.clock = host->f_min;
 
 	host->ios.power_mode = MMC_POWER_ON;
 	mmc_set_ios(host);
-- 1.6.0.4 

From: <r66093@freescale.com>
Subject: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
Date: Tue, 30 Oct 2012 16:12:46 +0800
Message-ID: <1351584769-16662-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:28284
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422Ab2J3IzW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 04:55:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

When f_init is zero, the SDHC can't work correctly. So f_min will replace
f_init, when f_init is zero.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- add the CC
changes for v3:
	- enalbe the controller clock in platform, instead of core

 drivers/mmc/core/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 06c42cf..9c162cd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1319,7 +1319,10 @@ static void mmc_power_up(struct mmc_host *host)
 	 */
 	mmc_delay(10);
 
-	host->ios.clock = host->f_init;
+	if (host->f_init)
+		host->ios.clock = host->f_init;
+	else
+		host->ios.clock = host->f_min;
 
 	host->ios.power_mode = MMC_POWER_ON;
 	mmc_set_ios(host);
-- 
1.7.9.5



From: <r66093@freescale.com>
Subject: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
Date: Tue, 6 Dec 2011 17:18:27 +0800
Message-ID: <1323163107-32619-2-git-send-email-r66093@freescale.com>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:27298
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933154Ab1LFKfz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 05:35:55 -0500
In-Reply-To: <1323163107-32619-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

When f_init is zero, the SDHC can't work correctly. So f_min will replace
f_init, when f_init is zero.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- add the CC

 drivers/mmc/core/core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a08e6b1..2d40c04 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1253,7 +1253,10 @@ static void mmc_power_up(struct mmc_host *host)
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
1.7.5.4



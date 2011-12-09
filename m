From: <r66093@freescale.com>
Subject: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
Date: Fri, 9 Dec 2011 10:53:47 +0800
Message-ID: <1323399230-29118-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:1153 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1LIDlD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 22:41:03 -0500
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
changes for v3:
	- enalbe the controller clock in platform, instead of core

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



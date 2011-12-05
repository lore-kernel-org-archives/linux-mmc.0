From: <r66093@freescale.com>
Subject: [PATCH 4/4] MMC/core: Add f_min to mmc_power_on()
Date: Mon, 5 Dec 2011 17:23:46 +0800
Message-ID: <1323077026-12071-4-git-send-email-r66093@freescale.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
 <1323077026-12071-2-git-send-email-r66093@freescale.com>
 <1323077026-12071-3-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:41323
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755777Ab1LEKlH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 05:41:07 -0500
Received: from mail33-db3 (localhost [127.0.0.1])	by mail33-db3-R.bigfish.com
 (Postfix) with ESMTP id 4862A680338	for <linux-mmc@vger.kernel.org>; Mon,  5
 Dec 2011 10:41:06 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.244])	by
 mail33-db3.bigfish.com (Postfix) with ESMTP id 26D93100043	for
 <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2011 10:41:06 +0000 (UTC)
In-Reply-To: <1323077026-12071-3-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

When f_init is zero, the SDHC can't work correctly. So f_min will replace
f_init, when f_init is zero.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
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



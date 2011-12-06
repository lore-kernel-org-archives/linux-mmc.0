From: <r66093@freescale.com>
Subject: [PATCH 2/5] MMC/core: Add f_min to mmc_power_on()
Date: Tue, 6 Dec 2011 17:15:34 +0800
Message-ID: <1323162937-7742-2-git-send-email-r66093@freescale.com>
References: <1323162937-7742-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:55245 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933272Ab1LFKdL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 05:33:11 -0500
Received: from mail135-tx2 (localhost [127.0.0.1])	by
 mail135-tx2-R.bigfish.com (Postfix) with ESMTP id 17ACF3C02D1	for
 <linux-mmc@vger.kernel.org>; Tue,  6 Dec 2011 10:33:11 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.245])	by
 mail135-tx2.bigfish.com (Postfix) with ESMTP id DA76F28004A	for
 <linux-mmc@vger.kernel.org>; Tue,  6 Dec 2011 10:33:10 +0000 (UTC)
In-Reply-To: <1323162937-7742-1-git-send-email-r66093@freescale.com>
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



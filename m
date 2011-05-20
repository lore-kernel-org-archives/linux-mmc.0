From: <r66093@freescale.com>
Subject: [PATCH 3/3] SDHC/MMC: add f_min to mmc_power_on
Date: Fri, 20 May 2011 15:35:14 +0800
Message-ID: <1305876914-23714-3-git-send-email-r66093@freescale.com>
References: <1305876914-23714-1-git-send-email-r66093@freescale.com>
 <1305876914-23714-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:44287
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934688Ab1ETIXc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 04:23:32 -0400
Received: from mail23-va3 (localhost.localdomain [127.0.0.1])	by
 mail23-va3-R.bigfish.com (Postfix) with ESMTP id 15E546B820E	for
 <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 08:23:32 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.252])	by
 mail23-va3.bigfish.com (Postfix) with ESMTP id C6DB529004E	for
 <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 08:23:31 +0000 (UTC)
In-Reply-To: <1305876914-23714-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <r66093@freescale.com>

From: Jerry Huang <r66093@freescale.com>

1. when f_init is zero, the SDHC can't work correctly, so f_min will replace it.
2. Before running get_cd recall function to detect if the card is present,
   must make sure the power is up.

Signed-off-by: Jerry Huang <r66093@freescale.com>
---
 drivers/mmc/core/core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1f453ac..5a22b85 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -993,7 +993,10 @@ static void mmc_power_up(struct mmc_host *host)
 	 */
 	mmc_delay(10);
 
-	host->ios.clock = host->f_init;
+	if (host->f_init)
+		host->ios.clock = host->f_init;
+	else
+		host->ios.clock = host->f_min;
 
 	host->ios.power_mode = MMC_POWER_ON;
 	mmc_set_ios(host);
@@ -1571,8 +1574,10 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
+	mmc_power_up(host);
 	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
 		goto out;
+	mmc_power_off(host);
 
 	mmc_claim_host(host);
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
-- 
1.7.4.1



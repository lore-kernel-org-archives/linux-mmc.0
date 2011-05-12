From: <r66093@freescale.com>
Subject: [PATCH 3/3] SDHC/MMC: add f_min to mmc_power_on
Date: Thu, 12 May 2011 13:24:17 +0800
Message-ID: <1305177857-4017-3-git-send-email-r66093@freescale.com>
References: <1305177857-4017-1-git-send-email-r66093@freescale.com>
 <1305177857-4017-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:36197 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab1ELGM3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 02:12:29 -0400
Received: from mail44-tx2 (localhost.localdomain [127.0.0.1])	by
 mail44-tx2-R.bigfish.com (Postfix) with ESMTP id 3EB1C10506C4	for
 <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 06:12:25 +0000 (UTC)
Received: from TX2EHSMHS017.bigfish.com (unknown [10.9.14.245])	by
 mail44-tx2.bigfish.com (Postfix) with ESMTP id 53155FD017B	for
 <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 06:11:19 +0000 (UTC)
In-Reply-To: <1305177857-4017-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

1. when f_init is zero, the SDHC can't work correctly, so f_min will replace it.
2. Before running get_cd recall function to detect if the card is present,
   must make sure the power is up.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
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



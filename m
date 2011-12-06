From: <r66093@freescale.com>
Subject: [PATCH 1/5 v2] MMC/core: Make sure the power is up, when detect the card
Date: Tue, 6 Dec 2011 17:18:26 +0800
Message-ID: <1323163107-32619-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:52954
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933096Ab1LFKgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 05:36:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Before running get_cd() recall function to detect whether the card is
present, must make sure the power is up.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- add the CC

 drivers/mmc/core/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5278ffb..a08e6b1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2066,8 +2066,10 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
+	mmc_power_up(host);
 	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
 		goto out;
+	mmc_power_off(host);
 
 	mmc_claim_host(host);
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
-- 
1.7.5.4



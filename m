From: <r66093@freescale.com>
Subject: [PATCH 1/5] MMC/core: Make sure the power is up, when detect the card
Date: Tue, 6 Dec 2011 17:15:33 +0800
Message-ID: <1323162937-7742-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:59854
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933242Ab1LFKdD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 05:33:03 -0500
Received: from mail107-va3 (localhost [127.0.0.1])	by
 mail107-va3-R.bigfish.com (Postfix) with ESMTP id 4D02F200275	for
 <linux-mmc@vger.kernel.org>; Tue,  6 Dec 2011 10:33:00 +0000 (UTC)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.249])	by
 mail107-va3.bigfish.com (Postfix) with ESMTP id D4F3B48008A	for
 <linux-mmc@vger.kernel.org>; Tue,  6 Dec 2011 10:32:59 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Before running get_cd() recall function to detect whether the card is
present, must make sure the power is up.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
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



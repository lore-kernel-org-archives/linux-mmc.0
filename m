From: <r66093@freescale.com>
Subject: [PATCH 1/5 v3] MMC/core: Make sure the power is up when detect the card
Date: Wed, 7 Dec 2011 09:34:32 +0800
Message-ID: <1323221673-27667-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:42010 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab1LGCwP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 21:52:15 -0500
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
changes for v3:
	- use power_up/off only when get_cd defined

 drivers/mmc/core/core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5278ffb..a863a41 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2066,8 +2066,14 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
-	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
-		goto out;
+	if (host->ops->get_cd) {
+		int err;
+		mmc_power_up(host);
+		err = host->ops->get_cd(host);
+		mmc_power_off(host);
+		if (err == 0)
+			goto out;
+	}
 
 	mmc_claim_host(host);
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
-- 
1.7.5.4



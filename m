From: <r66093@freescale.com>
Subject: [PATCH 3/4] MMC/core: Make sure the power is up, when detect the card
Date: Mon, 5 Dec 2011 17:23:45 +0800
Message-ID: <1323077026-12071-3-git-send-email-r66093@freescale.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
 <1323077026-12071-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:22915 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab1LEKlD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 05:41:03 -0500
Received: from mail9-tx2 (localhost [127.0.0.1])	by mail9-tx2-R.bigfish.com
 (Postfix) with ESMTP id 7BB27E0327	for <linux-mmc@vger.kernel.org>; Mon,  5
 Dec 2011 10:41:01 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.242])	by
 mail9-tx2.bigfish.com (Postfix) with ESMTP id 5C8766001E8	for
 <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2011 10:41:01 +0000 (UTC)
In-Reply-To: <1323077026-12071-2-git-send-email-r66093@freescale.com>
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



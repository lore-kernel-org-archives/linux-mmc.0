From: <r66093@freescale.com>
Subject: [PATCH 2/4] MMC/SD: Add callback function to detect card
Date: Mon, 5 Dec 2011 17:23:44 +0800
Message-ID: <1323077026-12071-2-git-send-email-r66093@freescale.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:3430 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448Ab1LEKnK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 05:43:10 -0500
Received: from mail132-tx2 (localhost [127.0.0.1])	by
 mail132-tx2-R.bigfish.com (Postfix) with ESMTP id BD93A6003BD	for
 <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2011 10:43:09 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.248])	by
 mail132-tx2.bigfish.com (Postfix) with ESMTP id 7B21454011B	for
 <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2011 10:41:01 +0000 (UTC)
In-Reply-To: <1323077026-12071-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

In order to check whether the card has been removed, the function
mmc_send_status() will send command CMD13 to card and ask the card
to send its status register to sdhc driver, which will generate
many interrupts repeatedly and make the system performance bad.

Therefore, add callback function get_cd() to check whether
the card has been removed when the driver has this callback function.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/core/mmc.c |    5 ++++-
 drivers/mmc/core/sd.c  |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index dbf421a..7ab404c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1115,7 +1115,10 @@ static void mmc_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	if (host->ops->get_cd)
+		err = !host->ops->get_cd(host);
+	else
+		err = mmc_send_status(host->card, NULL);
 
 	mmc_release_host(host);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index f2a05ea..c652883 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1033,7 +1033,10 @@ static void mmc_sd_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	if (host->ops->get_cd)
+		err = !host->ops->get_cd(host);
+	else
+		err = mmc_send_status(host->card, NULL);
 
 	mmc_release_host(host);
 
-- 
1.7.5.4



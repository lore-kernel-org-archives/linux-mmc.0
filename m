From: <r66093@freescale.com>
Subject: [PATCH 2/3] MMC/SD: add callback function to detect card
Date: Fri, 20 May 2011 15:35:13 +0800
Message-ID: <1305876914-23714-2-git-send-email-r66093@freescale.com>
References: <1305876914-23714-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:44213
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934688Ab1ETIXb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 04:23:31 -0400
Received: from mail16-va3 (localhost.localdomain [127.0.0.1])	by
 mail16-va3-R.bigfish.com (Postfix) with ESMTP id 900331280202	for
 <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 08:23:30 +0000 (UTC)
Received: from VA3EHSMHS007.bigfish.com (unknown [10.7.14.247])	by
 mail16-va3.bigfish.com (Postfix) with ESMTP id 149431598052	for
 <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 08:23:29 +0000 (UTC)
In-Reply-To: <1305876914-23714-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <r66093@freescale.com>

From: Jerry Huang <r66093@freescale.com>

Add callback function to check if the card has been removed.

in order to check if the card has been removed, the function mmc_send_status
will send commad CMD13 to card and ask the card to send its status register
to sdhc driver, which will generate interrupt repeatly and make the performance
of the system bad.
Therefore, get_cd callback is used to detect the card if the driver has.

Signed-off-by: Jerry Huang <r66093@freescale.com>
---
 drivers/mmc/core/mmc.c |    5 ++++-
 drivers/mmc/core/sd.c  |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 772d0d0..137d529 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -713,7 +713,10 @@ static void mmc_detect(struct mmc_host *host)
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
index 6dac89f..b85df32 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -673,7 +673,10 @@ static void mmc_sd_detect(struct mmc_host *host)
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
1.7.4.1



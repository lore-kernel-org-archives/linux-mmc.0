From: <r66093@freescale.com>
Subject: [PATCH 2/4 v3] MMC/SD: Add callback function to detect card
Date: Fri, 9 Dec 2011 10:53:48 +0800
Message-ID: <1323399230-29118-2-git-send-email-r66093@freescale.com>
References: <1323399230-29118-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:1400 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1LIDlO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2011 22:41:14 -0500
In-Reply-To: <1323399230-29118-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

In order to check whether the card has been removed, the function
mmc_send_status() will send command CMD13 to card and ask the card
to send its status register to sdhc driver, which will generate
many interrupts repeatedly and make the system performance bad.

Therefore, add callback function get_cd() to check whether
the card has been removed when the driver has this callback function.

If the card is present, 1 will return, if the card is absent, 0 will return.
If the controller will not support this feature, -ENOSYS will return.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- when controller don't support get_cd, return -ENOSYS
	- add the CC
changes for v3:
	- enalbe the controller clock in platform, instead of core

 drivers/mmc/core/mmc.c |   10 ++++++++--
 drivers/mmc/core/sd.c  |   10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index dbf421a..e03860e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1105,7 +1105,7 @@ static void mmc_remove(struct mmc_host *host)
  */
 static void mmc_detect(struct mmc_host *host)
 {
-	int err;
+	int err = -ENOSYS;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -1115,7 +1115,13 @@ static void mmc_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	if (host->ops->get_cd) {
+		err = host->ops->get_cd(host);
+		if (err >= 0)
+			err = !err;
+	}
+	if (err < 0)
+		err = mmc_send_status(host->card, NULL);
 
 	mmc_release_host(host);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index f2a05ea..7e61bf0 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1023,7 +1023,7 @@ static void mmc_sd_remove(struct mmc_host *host)
  */
 static void mmc_sd_detect(struct mmc_host *host)
 {
-	int err;
+	int err = -ENOSYS;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -1033,7 +1033,13 @@ static void mmc_sd_detect(struct mmc_host *host)
 	/*
 	 * Just check if our card has been removed.
 	 */
-	err = mmc_send_status(host->card, NULL);
+	if (host->ops->get_cd) {
+		err = host->ops->get_cd(host);
+		if (err >= 0)
+			err = !err;
+	}
+	if (err < 0)
+		err = mmc_send_status(host->card, NULL);
 
 	mmc_release_host(host);
 
-- 
1.7.5.4



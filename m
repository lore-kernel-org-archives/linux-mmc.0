From: <r66093@freescale.com>
Subject: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Tue, 30 Oct 2012 16:12:47 +0800
Message-ID: <1351584769-16662-2-git-send-email-r66093@freescale.com>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:5990
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756425Ab2J3Iz2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 04:55:28 -0400
In-Reply-To: <1351584769-16662-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

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
CC: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
        - when controller don't support get_cd, return -ENOSYS
        - add the CC
changes for v3:
        - enalbe the controller clock in platform, instead of core
changes for v4:
	- move the detect code to core.c according to the new structure

 drivers/mmc/core/core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9c162cd..6412355 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2073,7 +2073,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 
 int _mmc_detect_card_removed(struct mmc_host *host)
 {
-	int ret;
+	int ret = -ENOSYS;
 
 	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
 		return 0;
@@ -2081,7 +2081,13 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 	if (!host->card || mmc_card_removed(host->card))
 		return 1;
 
-	ret = host->bus_ops->alive(host);
+	if (host->ops->get_cd) {
+		ret = host->ops->get_cd(host);
+		if (ret >= 0)
+			ret = !ret;
+	}
+	if (ret < 0)
+		ret = host->bus_ops->alive(host);
 	if (ret) {
 		mmc_card_set_removed(host->card);
 		pr_debug("%s: card remove detected\n", mmc_hostname(host));
-- 
1.7.9.5



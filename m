From: <r66093@freescale.com>
Subject: [PATCH 1/3 v5] MMC/SD: Add callback function to detect card
Date: Mon, 19 Nov 2012 13:27:24 +0800
Message-ID: <1353302846-19514-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:46895 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab2KSGNm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 01:13:42 -0500
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
Reviewed-by: Johan Rudholm <johan.rudholm@stericsson.com>
Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
        - when controller don't support get_cd, return -ENOSYS
        - add the CC
changes for v3:
        - enalbe the controller clock in platform, instead of core
changes for v4:
	- move the detect code to core.c according to the new structure
changes for v5:
	- reviewed by Anton and Johan, add the reviewed-by.

 drivers/mmc/core/core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aaed768..1bc1cb5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2100,7 +2100,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 
 int _mmc_detect_card_removed(struct mmc_host *host)
 {
-	int ret;
+	int ret = -ENOSYS;
 
 	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
 		return 0;
@@ -2108,7 +2108,13 @@ int _mmc_detect_card_removed(struct mmc_host *host)
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



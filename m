From: <Chang-Ming.Huang@freescale.com>
Subject: [PATCH 1/3i v6] MMC/SD: Add callback function to detect card
Date: Wed, 20 Mar 2013 13:41:33 +0800
Message-ID: <1363758095-32378-1-git-send-email-Chang-Ming.Huang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:51352
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810Ab3CTGQc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 02:16:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

In order to check whether the card has been removed, the function
mmc_send_status() will send command CMD13 to card and ask the card
to send its status register to sdhc driver, which will generate
many interrupts repeatedly and make the system performance bad.
>From the performance test on Freescale's board (such as Iozone for SD),
the performance will degrade about 4~6%.

There is one another way to get this information,
which is to read the register PRSSTAT and check the bit CDPL or CINS.
If the card is present, these two bit will set to one.
Therefore, add callback function get_cd() to check whether
the card has been inserted/removed when the driver supports this feature.
If the card is present, 0 will return, if the card is absent, 1 will return.
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
changes for v6:
	- add more comment.

 drivers/mmc/core/core.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 08a3cf2..e225deb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2280,7 +2280,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 
 int _mmc_detect_card_removed(struct mmc_host *host)
 {
-	int ret;
+	int ret = -ENOSYS;
 
 	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
 		return 0;
@@ -2288,7 +2288,19 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 	if (!host->card || mmc_card_removed(host->card))
 		return 1;
 
-	ret = host->bus_ops->alive(host);
+	/* First, try host-controller's card detect callback */
+	if (host->ops->get_cd) {
+		ret = host->ops->get_cd(host);
+		/*
+		 * The return value from get_cd: 1 for present, 0 for absent,
+		 * we need to convert it to: 1 for absent, 0 for present.
+		 */
+		if (ret >= 0)
+			ret = !ret;
+	}
+	/* If failed, back to the bus_ops alive() callback */
+	if (ret < 0)
+		ret = host->bus_ops->alive(host);
 	if (ret) {
 		mmc_card_set_removed(host->card);
 		pr_debug("%s: card remove detected\n", mmc_hostname(host));
-- 
1.7.9.5



From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci: improve card removal check in sdhci_card_event()
Date: Sun, 9 Jun 2013 19:49:24 +0800
Message-ID: <1370778564-32695-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:35573
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753289Ab3FILtQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 07:49:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>

The following error randomly appears on an imx6q board where gpio is
used to implement card-detection when mounting EXT4 rootfs during boot.

mmc1: Card removed during transfer!
mmc1: Resetting controller.
mmcblk0: unknown error -123 sending read/write command, card status 0x900
end_request: I/O error, dev mmcblk0, sector 106744
EXT4-fs error (device mmcblk0p2): ext4_find_entry:1312: inode #5011: comm swapper/0: reading directory lblock 0

It turns out that the error message comes from the card removal check
in function sdhci_card_event().  While we have a well implemented
function sdhci_do_get_cd() handling all the possible cases of
CD, the current code only checks controller internal CD case.  That
causes problem for other CD cases like gpio on above imx6q board.

Improve the check by using sdhci_do_get_cd() to cover all possible CD
cases, so that above error on the imx6q board gets fixed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c81c2a2..eadb3ad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2066,8 +2066,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_lock_irqsave(&host->lock, flags);
 
 	/* Check host->mrq first in case we are runtime suspended */
-	if (host->mrq &&
-	    !(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
+	if (host->mrq && !sdhci_do_get_cd(host)) {
 		pr_err("%s: Card removed during transfer!\n",
 			mmc_hostname(host->mmc));
 		pr_err("%s: Resetting controller.\n",
-- 
1.7.9.5



From: Mikko Vinni <mmvinni@yahoo.com>
Subject: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Mon,  7 Mar 2011 22:40:57 +0200
Message-ID: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.shellit.org ([81.22.255.73]:45516 "EHLO mail.shellit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756140Ab1CGUyZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Mar 2011 15:54:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Mikko Vinni <mmvinni@yahoo.com>

Some SD host controllers (noticed on an integrated JMicron SD reader
on an HP Pavilion dv5-1250eo laptop) don't update the dma address
register before signaling a dma interrupt due to a dma boundary.
Detect this and update the register to the next 512KB boundary,
at which the transfer presumably stopped.

As long as each transfer is at most 512KB in size (on this hardware
the max seems to be 65536 bytes), this fix is needed at most once
per transfer.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=28462

Signed-off-by: Mikko Vinni <mmvinni <at> yahoo.com>
---
Sent on 2011-02-21 21:23:32 GMT
(http://thread.gmane.org/gmane.linux.kernel.mmc/5568/focus=6145)

Hoping to be able to drop this patch eventually from my own
repo and have the hardware just work with mainline code.
Maybe first in -next if nobody sees any serious problems
straight away?

This patch should not break anything for anybody whose
hardware isn't already broken.

 drivers/mmc/host/sdhci.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a25db42..8651731 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1537,9 +1537,27 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * boundaries, but as we can't disable the feature
 		 * we need to at least restart the transfer.
 		 */
-		if (intmask & SDHCI_INT_DMA_END)
-			sdhci_writel(host, sdhci_readl(host, SDHCI_DMA_ADDRESS),
-				SDHCI_DMA_ADDRESS);
+		if (intmask & SDHCI_INT_DMA_END) {
+			u32 dmastart, dmanow;
+			dmastart = sg_dma_address(host->data->sg);
+			dmanow = sdhci_readl(host, SDHCI_DMA_ADDRESS);
+			if (dmanow == dmastart) {
+				/*
+				 * HW failed to increase the address.
+				 * Update to the next 512KB block boundary.
+				 */
+				dmanow = (dmanow & ~0x7ffff) + 0x80000;
+				if (dmanow > dmastart + host->data->blksz *
+							host->data->blocks) {
+					WARN_ON(1);
+					dmanow = dmastart;
+				}
+				DBG("%s: next DMA address forced "
+				    "from 0x%08x to 0x%08x\n",
+				    mmc_hostname(host->mmc), dmastart, dmanow);
+			}
+			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
 			if (host->cmd) {
-- 
1.7.4.1


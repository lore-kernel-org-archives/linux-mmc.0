From: Mikko Vinni <mmvinni@yahoo.com>
Subject: [PATCH] sdhci: work around broken dma boundary behaviour
Date: Mon, 21 Feb 2011 21:23:32 +0000 (UTC)
Message-ID: <loom.20110221T221815-772@post.gmane.org>
References: <403485.93468.qm@web161809.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59786 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab1BUVaG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Feb 2011 16:30:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1PrdKW-0004Q6-Bk
	for linux-mmc@vger.kernel.org; Mon, 21 Feb 2011 22:30:04 +0100
Received: from 85-156-14-70.elisa-mobile.fi ([85.156.14.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 22:30:04 +0100
Received: from mmvinni by 85-156-14-70.elisa-mobile.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 22:30:04 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Some SD host controllers (noticed on an integrated JMicron SD reader
on an HP Pavilion dv5-1250eo laptop) don't update the dma address
register before signalling a dma interrupt due to a dma boundary.
Detect this and update the register to the next 512KB boundary,
at which the transfer presumably stopped. As long as each transfer
is at most 512KB in size (on this hardware the max seems to be
65536 bytes), this fix is neeeded at most once per transfer.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=28462

Signed-off-by: Mikko Vinni <mmvinni@yahoo.com>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a25db42..469cf74 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1537,9 +1537,27 @@ static void sdhci_data_irq(struct sdhci_host *host, u32
intmask)
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



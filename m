From: Mikko Vinni <mmvinni@yahoo.com>
Subject: [RFC] mmc: sdhci: work around broken dma boundary behavior
Date: Tue, 29 Mar 2011 11:53:34 +0300
Message-ID: <1301388814-10931-1-git-send-email-mmvinni@yahoo.com>
References: <20110314172129.GA20654@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail1.shellit.org ([81.22.255.73]:60359 "EHLO mail.shellit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab1C2IyM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Mar 2011 04:54:12 -0400
In-Reply-To: <20110314172129.GA20654@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Mikko Vinni <mmvinni@yahoo.com>

Some SD host controllers (noticed on an integrated JMicron
SD reader on an HP Pavilion dv5-1250eo laptop) don't update
the dma address register before signaling a dma interrupt due
to a dma boundary. Update the register manually to the next
boundary (by default 512KiB), at which the transfer stopped.

As long as each transfer is at most 512KiB in size (guaranteed
by a BUG_ON in sdhci_prepare_data()) and the boundary is kept
at the default value, this fix is needed at most once per
transfer. Smaller boundaries are taken care of by counting
the transferred bytes.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=28462

Signed-off-by: Mikko Vinni <mmvinni@yahoo.com>
---
 
This is alternative to
http://article.gmane.org/gmane.linux.kernel.mmc/6497

The main concern about the original patch was that it won't
work for if the boundary is made smaller and a large transfer
would cross the boundary twice. With this version this is taken
care of by re-using the bytes_xfered field from struct mmc_data.

Grepping through the code revealed no other uses of bytes_xfered
in host/sdhci.c except after the transfer is complete.

This patch has been tested with at least the boundary sizes
4, 8, 32, and 512KiB. The mmc-test tests all passed when tested
with 32KiB. This is on the "broken" controller. No other card readers
were tested so far.

The added debug output looks like this:

sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000008
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x00100000, transferred 0x008000 bytes, next 0x00108000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000008
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x00100000, transferred 0x010000 bytes, next 0x00110000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000008
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x00100000, transferred 0x018000 bytes, next 0x00118000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000008
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x00100000, transferred 0x020000 bytes, next 0x00120000

In my opinion this is more risky than the original patch
because this will affect the behavior on all controllers that
use sdhci, and not just on those ones that don't update SDHCI_DMA_ADDRESS
themselves. Comments welcome!

 drivers/mmc/host/sdhci.c |   30 +++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.h |    6 ++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..0319903 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -669,6 +669,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 
 	host->data = data;
 	host->data_early = 0;
+	host->data->bytes_xfered = 0;
 
 	count = sdhci_calc_timeout(host, data);
 	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
@@ -807,8 +808,9 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 
 	sdhci_set_transfer_irqs(host);
 
-	/* We do not handle DMA boundaries, so set it to max (512 KiB) */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, data->blksz), SDHCI_BLOCK_SIZE);
+	/* Set the DMA boundary value and block size */
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
+		data->blksz), SDHCI_BLOCK_SIZE);
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
 
@@ -1544,10 +1546,28 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * We currently don't do anything fancy with DMA
 		 * boundaries, but as we can't disable the feature
 		 * we need to at least restart the transfer.
+		 *
+		 * According to the spec sdhci_readl(host, SDHCI_DMA_ADDRESS)
+		 * should return a valid address to continue from, but as
+		 * some controllers are faulty, don't trust them.
 		 */
-		if (intmask & SDHCI_INT_DMA_END)
-			sdhci_writel(host, sdhci_readl(host, SDHCI_DMA_ADDRESS),
-				SDHCI_DMA_ADDRESS);
+		if (intmask & SDHCI_INT_DMA_END) {
+			u32 dmastart, dmanow;
+			dmastart = sg_dma_address(host->data->sg);
+			dmanow = dmastart + host->data->bytes_xfered;
+			/*
+			 * Force update to the next DMA block boundary.
+			 */
+			dmanow = (dmanow &
+				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+				SDHCI_DEFAULT_BOUNDARY_SIZE;
+			host->data->bytes_xfered = dmanow - dmastart;
+			DBG("%s: DMA base 0x%08x, transferred 0x%06x bytes,"
+				" next 0x%08x\n",
+				mmc_hostname(host->mmc), dmastart,
+				host->data->bytes_xfered, dmanow);
+			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
 			if (host->cmd) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 25e8bde..85750a9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -202,6 +202,12 @@
 #define SDHCI_MAX_DIV_SPEC_200	256
 #define SDHCI_MAX_DIV_SPEC_300	2046
 
+/*
+ * Host SDMA buffer boundary. Valid values from 4K to 512K in powers of 2.
+ */
+#define SDHCI_DEFAULT_BOUNDARY_SIZE  (512 * 1024)
+#define SDHCI_DEFAULT_BOUNDARY_ARG   (ilog2(SDHCI_DEFAULT_BOUNDARY_SIZE) - 12)
+
 struct sdhci_ops {
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
 	u32		(*read_l)(struct sdhci_host *host, int reg);
-- 
1.7.4.1


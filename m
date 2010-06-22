From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 11/12] mmci: support different FIFO sizes
Date: Tue, 22 Jun 2010 14:47:46 +0530
Message-ID: <1277198267-10860-11-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:51626 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759118Ab0FVJTM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:19:12 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

The Ux500 variant has a 32-word FIFO (TXFIFOEMPTY is asserted when it
has 2 left) and TXFIFOHALFEMPTY is repurposed as TXFIFOBURSTWRITEABLE,
with a burst being defined as 8-words.  Likewise for RX.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |   22 +++++++++++++++++++---
 drivers/mmc/host/mmci.h |    7 -------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 6c8e41b..4eb7265 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -41,23 +41,35 @@ static unsigned int fmax = 515633;
  * @clkreg: default value for MCICLOCK register
  * @clkreg_enable: enable value for MMCICLOCK register
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
+ * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
+ *	      is asserted (likewise for RX)
+ * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
+ *		  is asserted (likewise for RX)
  */
 struct variant_data {
 	unsigned int		clkreg;
 	unsigned int		clkreg_enable;
 	unsigned int		datalength_bits;
+	unsigned int		fifosize;
+	unsigned int		fifohalfsize;
 };
 
 static struct variant_data variant_arm = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
 	.datalength_bits	= 16,
 };
 
 static struct variant_data variant_u300 = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
 	.clkreg_enable		= 1 << 13, /* HWFCEN */
 	.datalength_bits	= 16,
 };
 
 static struct variant_data variant_ux500 = {
+	.fifosize		= 30 * 4,
+	.fifohalfsize		= 8 * 4,
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
 	.datalength_bits	= 24,
@@ -138,6 +150,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
+	struct variant_data *variant = host->variant;
 	unsigned int datactrl, timeout, irqmask;
 	unsigned long long clks;
 	void __iomem *base;
@@ -173,7 +186,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		 * If we have less than a FIFOSIZE of bytes to transfer,
 		 * trigger a PIO interrupt as soon as any data is available.
 		 */
-		if (host->size < MCI_FIFOSIZE)
+		if (host->size < variant->fifosize)
 			irqmask |= MCI_RXDATAAVLBLMASK;
 	} else {
 		/*
@@ -316,13 +329,15 @@ static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int rema
 
 static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int remain, u32 status)
 {
+	struct variant_data *variant = host->variant;
 	void __iomem *base = host->base;
 	char *ptr = buffer;
 
 	do {
 		unsigned int count, maxcnt;
 
-		maxcnt = status & MCI_TXFIFOEMPTY ? MCI_FIFOSIZE : MCI_FIFOHALFSIZE;
+		maxcnt = status & MCI_TXFIFOEMPTY ?
+			 variant->fifosize : variant->fifohalfsize;
 		count = min(remain, maxcnt);
 
 		writesl(base + MMCIFIFO, ptr, count >> 2);
@@ -346,6 +361,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
 	struct sg_mapping_iter *sg_miter = &host->sg_miter;
+	struct variant_data *variant = host->variant;
 	void __iomem *base = host->base;
 	unsigned long flags;
 	u32 status;
@@ -401,7 +417,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 * If we're nearing the end of the read, switch to
 	 * "any data available" mode.
 	 */
-	if (status & MCI_RXACTIVE && host->size < MCI_FIFOSIZE)
+	if (status & MCI_RXACTIVE && host->size < variant->fifosize)
 		writel(MCI_RXDATAAVLBLMASK, base + MMCIMASK1);
 
 	/*
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 0a11ddc..c7d373c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -133,13 +133,6 @@
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
 	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
 
-/*
- * The size of the FIFO in bytes.
- */
-#define MCI_FIFOSIZE	(16*4)
-	
-#define MCI_FIFOHALFSIZE (MCI_FIFOSIZE / 2)
-
 #define NR_SG		16
 
 struct clk;
-- 
1.7.0


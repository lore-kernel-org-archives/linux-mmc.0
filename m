From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 12/12] mmci: support variants with only one irq
Date: Tue, 22 Jun 2010 14:47:47 +0530
Message-ID: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:48100 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759115Ab0FVJTT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:19:19 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

The Ux500 variants have only one IRQ line hooked up.  Allow these to
work by directing the PIO interrupts also to the first IRQ line.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |   67 ++++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/mmci.h |    5 +++
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4eb7265..5baa3bd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -45,6 +45,7 @@ static unsigned int fmax = 515633;
  *	      is asserted (likewise for RX)
  * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
  *		  is asserted (likewise for RX)
+ * @singleirq: true if only one IRQ line is available
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -52,6 +53,7 @@ struct variant_data {
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
+	bool			singleirq;
 };
 
 static struct variant_data variant_arm = {
@@ -73,7 +75,9 @@ static struct variant_data variant_ux500 = {
 	.clkreg			= MCI_CLK_ENABLE,
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
 	.datalength_bits	= 24,
+	.singleirq		= true,
 };
+
 /*
  * This must be called with host->lock held
  */
@@ -129,10 +133,27 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	spin_lock(&host->lock);
 }
 
+static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
+{
+	struct variant_data *variant = host->variant;
+	void __iomem *base = host->base;
+
+	if (variant->singleirq) {
+		unsigned int mask0 = readl(base + MMCIMASK0);
+
+		mask0 &= ~MCI_IRQ1MASK;
+		mask0 |= mask;
+
+		writel(mask0, base + MMCIMASK0);
+	}
+
+	writel(mask, base + MMCIMASK1);
+}
+
 static void mmci_stop_data(struct mmci_host *host)
 {
 	writel(0, host->base + MMCIDATACTRL);
-	writel(0, host->base + MMCIMASK1);
+	mmci_set_mask1(host, 0);
 	host->data = NULL;
 }
 
@@ -198,7 +219,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	writel(datactrl, base + MMCIDATACTRL);
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
-	writel(irqmask, base + MMCIMASK1);
+	mmci_set_mask1(host, irqmask);
 }
 
 static void
@@ -260,6 +281,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	if (status & MCI_DATAEND) {
 		mmci_stop_data(host);
 
+		/* MCI_DATABLOCKEND not used with single irq */
+		if (host->variant->singleirq && !data->error)
+			host->data_xfered = data->blksz * data->blocks;
+
 		if (!data->stop) {
 			mmci_request_end(host, data->mrq);
 		} else {
@@ -418,7 +443,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 * "any data available" mode.
 	 */
 	if (status & MCI_RXACTIVE && host->size < variant->fifosize)
-		writel(MCI_RXDATAAVLBLMASK, base + MMCIMASK1);
+		mmci_set_mask1(host, MCI_RXDATAAVLBLMASK);
 
 	/*
 	 * If we run out of data, disable the data IRQs; this
@@ -427,7 +452,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	 * stops us racing with our data end IRQ.
 	 */
 	if (host->size == 0) {
-		writel(0, base + MMCIMASK1);
+		mmci_set_mask1(host, 0);
 		writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK, base + MMCIMASK0);
 	}
 
@@ -440,6 +465,7 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 static irqreturn_t mmci_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
+	struct variant_data *variant = host->variant;
 	u32 status;
 	int ret = 0;
 
@@ -450,6 +476,14 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		struct mmc_data *data;
 
 		status = readl(host->base + MMCISTATUS);
+
+		if (variant->singleirq) {
+			if (status & readl(host->base + MMCIMASK1))
+				mmci_pio_irq(irq, dev_id);
+
+			status &= ~MCI_IRQ1MASK;
+		}
+
 		status &= readl(host->base + MMCIMASK0);
 		writel(status, host->base + MMCICLEAR);
 
@@ -610,6 +644,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
 	struct mmc_host *mmc;
+	unsigned int mask;
 	int ret;
 
 	/* must have platform data */
@@ -782,11 +817,23 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	if (ret)
 		goto unmap;
 
-	ret = request_irq(dev->irq[1], mmci_pio_irq, IRQF_SHARED, DRIVER_NAME " (pio)", host);
-	if (ret)
-		goto irq0_free;
+	if (!variant->singleirq) {
+		ret = request_irq(dev->irq[1], mmci_pio_irq, IRQF_SHARED,
+				  DRIVER_NAME " (pio)", host);
+		if (ret)
+			goto irq0_free;
+	}
+
+	/*
+	 * MCI_DATABLOCKEND doesn't seem to immediately clear from the status,
+	 * so we can't use it keep count when only one irq is used because the
+	 * irq will hit for other reasons.
+	 */
+	mask = MCI_IRQENABLE;
+	if (variant->singleirq)
+		mask &= ~MCI_DATABLOCKEND;
 
-	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	writel(mask, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
 
@@ -830,6 +877,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
+		struct variant_data *variant = host->variant;
 
 		mmc_remove_host(mmc);
 
@@ -840,7 +888,8 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCIDATACTRL);
 
 		free_irq(dev->irq[0], host);
-		free_irq(dev->irq[1], host);
+		if (!variant->singleirq)
+			free_irq(dev->irq[1], host);
 
 		if (host->gpio_wp != -ENOSYS)
 			gpio_free(host->gpio_wp);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index c7d373c..ba203b8 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -133,6 +133,11 @@
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
 	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
 
+/* These interrupts are directed to IRQ1 when two IRQ lines are available */
+#define MCI_IRQ1MASK \
+	(MCI_RXFIFOHALFFULLMASK | MCI_RXDATAAVLBLMASK | \
+	 MCI_TXFIFOHALFEMPTYMASK)
+
 #define NR_SG		16
 
 struct clk;
-- 
1.7.0


From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 3/9] sdhci-3:add the NONSTANDARD_HOST_CTL quirk to support FSl
	eSDHC
Date: Wed, 1 Sep 2010 17:47:47 +0800
Message-ID: <1283334467-12602-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Richard Zhu <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Add NONSTANDARD_HOST_CTL quirk flags, because that FSL's eSDHC
don't have the standard HOST CTL register, add this quirk to
configure the bus_width and DMA properly.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/sdhci.c |   45 ++++++++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h |    3 +++
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e7e2611..2bfe738 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -777,7 +777,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 	 * (e.g. JMicron) can't do PIO properly when the selection
 	 * is ADMA.
 	 */
-	if (host->version >= SDHCI_SPEC_200) {
+	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_HOST_CTL) {
+		if (host->ops->enable_dma)
+			host->ops->enable_dma(host);
+		else
+			printk(KERN_ERR "%s: Failed to enable DMA!\n",
+				mmc_hostname(host->mmc));
+	} else if (host->version >= SDHCI_SPEC_200) {
 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 		ctrl &= ~SDHCI_CTRL_DMA_MASK;
 		if ((host->flags & SDHCI_REQ_USE_DMA) &&
@@ -1173,24 +1179,33 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_set_power(host, ios->vdd);
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
-	if (ios->bus_width == MMC_BUS_WIDTH_8)
-		ctrl |= SDHCI_CTRL_8BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_8BITBUS;
+	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_HOST_CTL) {
 
-	if (ios->bus_width == MMC_BUS_WIDTH_4)
-		ctrl |= SDHCI_CTRL_4BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		if (host->ops->set_bus)
+			host->ops->set_bus(host, ios->bus_width);
+		else
+			printk(KERN_ERR "Invalided BUS configurations!\n");
+	} else {
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
-	if (ios->timing == MMC_TIMING_SD_HS)
-		ctrl |= SDHCI_CTRL_HISPD;
-	else
-		ctrl &= ~SDHCI_CTRL_HISPD;
+		if (ios->bus_width == MMC_BUS_WIDTH_8)
+			ctrl |= SDHCI_CTRL_8BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_8BITBUS;
 
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+		if (ios->bus_width == MMC_BUS_WIDTH_4)
+			ctrl |= SDHCI_CTRL_4BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+
+		if (ios->timing == MMC_TIMING_SD_HS)
+			ctrl |= SDHCI_CTRL_HISPD;
+		else
+			ctrl &= ~SDHCI_CTRL_HISPD;
+
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
 
 	/*
 	 * Some (ENE) controllers go apeshit on some ios operation,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a4db2cc..029ab0e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -245,6 +245,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
 /* Controller uses Auto CMD12 command to stop the transfer */
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
+/* Controller doesn't have the standard Host Control registor */
+#define SDHCI_QUIRK_NONSTANDARD_HOST_CTL 		(1<<29)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -317,6 +319,7 @@ struct sdhci_ops {
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
 	void	(*set_power)(struct sdhci_host *host, unsigned int power);
+	void	(*set_bus)(struct sdhci_host *host, unsigned int bus);
 
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
-- 
1.7.0

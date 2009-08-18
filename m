From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 8/9] s3cmci: Kconfig selection for PIO/DMA/Both
Date: Tue, 18 Aug 2009 12:56:12 +0100
Message-ID: <20090818115659.922067924@fluff.org>
References: <20090818115604.056816271@fluff.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:55705 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758759AbZHRL5A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 07:57:00 -0400
Content-Disposition: inline; filename=s3cmci-dma-selection.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Add a selection for the data transfer mode of the s3cmci driver, allowing
for either a configuration or rumtime selection of the use of the DMA or
PIO transfer code.

The PIO only mode is 476 bytes smaller than the driver with both methods
compiled in.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 arch/arm/plat-s3c24xx/include/plat/mci.h |    1 
 drivers/mmc/host/Kconfig                 |   35 +++++++++++++++++++++++++++
 drivers/mmc/host/s3cmci.c                |   39 ++++++++++++++++++++++++-------
 3 files changed, 67 insertions(+), 8 deletions(-)

Index: b/drivers/mmc/host/Kconfig
===================================================================
--- a/drivers/mmc/host/Kconfig	2009-08-17 12:03:13.000000000 +0100
+++ b/drivers/mmc/host/Kconfig	2009-08-17 12:07:54.000000000 +0100
@@ -261,6 +261,41 @@ config MMC_S3C
 
 	  If unsure, say N.
 
+choice
+	prompt "Samsung S3C SD/MMC transfer code"
+	depends on MMC_S3C
+
+config MMC_S3C_PIO
+	bool "Use PIO transfers only"
+	default y
+	help
+	  Use PIO to transfer data between memory and the hardware.
+
+	  PIO is slower than DMA as it requires CPU instructions to
+	  move the data. This has been the traditional default for
+	  the S3C MCI driver.
+
+config MMC_S3C_DMA
+	bool "Use DMA transfers only (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Use DMA to transfer data between memory and the hardare.
+
+	  Currently, the DMA support in this driver seems to not be
+	  working properly and needs to be debugged before this
+	  option is useful.
+
+config MMC_S3C_PIODMA
+	bool "Support for both PIO and DMA (EXPERIMENTAL)"
+	help
+	  Compile both the PIO and DMA transfer routines into the
+	  driver and let the platform select at run-time which one
+	  is best.
+
+	  See notes for the DMA option.
+
+endchoice
+
 config MMC_SDRICOH_CS
 	tristate "MMC/SD driver for Ricoh Bay1Controllers (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PCI && PCMCIA
Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-08-17 12:05:44.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-08-17 19:24:20.000000000 +0100
@@ -164,6 +164,25 @@ static void dbg_dumpregs(struct s3cmci_h
 
 #endif /* CONFIG_MMC_DEBUG */
 
+/**
+ * s3cmci_host_usedma - return whether the host is using dma or pio
+ * @host: The host state
+ *
+ * Return true if the host is using DMA to transfer data, else false
+ * to use PIO mode. Will return static data depending on the driver
+ * configuration.
+ */
+static inline bool s3cmci_host_usedma(struct s3cmci_host *host)
+{
+#ifdef CONFIG_MMC_S3C_PIO
+	return false;
+#elif defined(CONFIG_MMC_S3C_DMA)
+	return true;
+#else
+	return host->dodma;
+#endif
+}
+
 static inline u32 enable_imask(struct s3cmci_host *host, u32 imask)
 {
 	u32 newmask;
@@ -560,7 +579,7 @@ static irqreturn_t s3cmci_irq(int irq, v
 		goto irq_out;
 	}
 
-	if (!host->dodma) {
+	if (!s3cmci_host_usedma(host)) {
 		if ((host->pio_active == XFER_WRITE) &&
 		    (mci_fsta & S3C2410_SDIFSTA_TFDET)) {
 
@@ -796,7 +815,7 @@ static void finalize_request(struct s3cm
 
 	if (cmd->data && (cmd->error == 0) &&
 	    (cmd->data->error == 0)) {
-		if (host->dodma && (!host->dma_complete)) {
+		if (s3cmci_host_usedma(host) && (!host->dma_complete)) {
 			dbg(host, dbg_dma, "DMA Missing!\n");
 			return;
 		}
@@ -848,7 +867,7 @@ static void finalize_request(struct s3cm
 	/* If we had an error while transfering data we flush the
 	 * DMA channel and the fifo to clear out any garbage. */
 	if (mrq->data->error != 0) {
-		if (host->dodma)
+		if (s3cmci_host_usedma(host))
 			s3c2410_dma_ctrl(host->dma, S3C2410_DMAOP_FLUSH);
 
 		if (host->is2440) {
@@ -968,7 +987,7 @@ static int s3cmci_setup_data(struct s3cm
 
 	dcon  = data->blocks & S3C2410_SDIDCON_BLKNUM_MASK;
 
-	if (host->dodma)
+	if (s3cmci_host_usedma(host))
 		dcon |= S3C2410_SDIDCON_DMAEN;
 
 	if (host->bus_width == MMC_BUS_WIDTH_4)
@@ -1114,7 +1133,7 @@ static void s3cmci_send_request(struct m
 			return;
 		}
 
-		if (host->dodma)
+		if (s3cmci_host_usedma(host))
 			res = s3cmci_prepare_dma(host, cmd->data);
 		else
 			res = s3cmci_prepare_pio(host, cmd->data);
@@ -1398,7 +1417,7 @@ static int s3cmci_state_show(struct seq_
 	seq_printf(seq, "IRQ disabled = %d\n", host->irq_disabled);
 	seq_printf(seq, "IRQ state = %d\n", host->irq_state);
 	seq_printf(seq, "CD IRQ = %d\n", host->irq_cd);
-	seq_printf(seq, "Do DMA = %d\n", host->dodma);
+	seq_printf(seq, "Do DMA = %d\n", s3cmci_host_usedma(host));
 	seq_printf(seq, "SDIIMSK at %d\n", host->sdiimsk);
 	seq_printf(seq, "SDIDATA at %d\n", host->sdidata);
 
@@ -1559,12 +1578,15 @@ static int __devinit s3cmci_probe(struct
 		host->clk_div	= 2;
 	}
 
-	host->dodma		= 0;
 	host->complete_what 	= COMPLETION_NONE;
 	host->pio_active 	= XFER_NONE;
 
 	host->dma		= S3CMCI_DMA;
 
+#ifdef CONFIG_MMC_S3C_PIODMA
+	host->dodma		= host->pdata->dma;
+#endif
+
 	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!host->mem) {
 		dev_err(&pdev->dev,
@@ -1702,7 +1724,8 @@ static int __devinit s3cmci_probe(struct
 	s3cmci_debugfs_attach(host);
 
 	platform_set_drvdata(pdev, mmc);
-	dev_info(&pdev->dev, "initialisation done.\n");
+	dev_info(&pdev->dev, "%s - using %s\n", mmc_hostname(mmc),
+		 s3cmci_host_usedma(host) ? "dma" : "pio");
 
 	return 0;
 
Index: b/arch/arm/plat-s3c24xx/include/plat/mci.h
===================================================================
--- a/arch/arm/plat-s3c24xx/include/plat/mci.h	2009-06-10 04:05:27.000000000 +0100
+++ b/arch/arm/plat-s3c24xx/include/plat/mci.h	2009-08-17 12:05:44.000000000 +0100
@@ -4,6 +4,7 @@
 struct s3c24xx_mci_pdata {
 	unsigned int	wprotect_invert : 1;
 	unsigned int	detect_invert : 1;   /* set => detect active high. */
+	unsigned int	use_dma : 1;
 
 	unsigned int	gpio_detect;
 	unsigned int	gpio_wprotect;

-- 

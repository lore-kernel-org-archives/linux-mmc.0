From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/7] sdhci: Rework some of the quirk behaviour
Date: Mon, 13 Sep 2010 18:38:48 +0100
Message-ID: <20100913173839.20345.27249.stgit@localhost.localdomain>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:18762 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab0IMSXZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:23:25 -0400
In-Reply-To: <20100913172738.20345.61119.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

As the quirks go ever more complex it's getting harder and harder to integrate
new drivers. The Intel MID devices add a whole further collection of new
quirks so instead of quirks start moving some stuff to overridable functions.

We also introduce an sdhci_reset_all helper which is told if the reset is
being done during init (which needs to be avoided by some hw) or on exit
in which case it doesn't.

Arguably the driver wants to be lots of drivers and "libsdhci" but that would
be a massive undertaking.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/Kconfig           |   11 ++
 drivers/mmc/host/Makefile          |    1 
 drivers/mmc/host/sdhci-intel-mid.c |  163 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.c       |   56 ++++++++++++
 drivers/mmc/host/sdhci.c           |   61 ++++++++++---
 drivers/mmc/host/sdhci.h           |   20 ++++
 include/linux/pci_ids.h            |    2 
 7 files changed, 296 insertions(+), 18 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-intel-mid.c


diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index ce099c4..ffa40f1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -81,6 +81,17 @@ config MMC_RICOH_MMC
 
 	  If unsure, say Y.
 
+config MMC_SDHCI_INTEL_MID
+	tristate "SDHCI support on Intel MID platforms"
+	depends on MMC_SDHCI_PCI
+	help
+	  This includes support for the SDHCI controllers found on Intel
+	  MID platform systems.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_OF
 	tristate "SDHCI support on OpenFirmware platforms"
 	depends on MMC_SDHCI && PPC_OF
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 697bbfe..21c80f0 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_MV)	+= sdhci-mv.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
+obj-$(CONFIG_MMC_SDHCI_INTEL_MID)	+= sdhci-intel-mid.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
diff --git a/drivers/mmc/host/sdhci-intel-mid.c b/drivers/mmc/host/sdhci-intel-mid.c
new file mode 100644
index 0000000..2828831
--- /dev/null
+++ b/drivers/mmc/host/sdhci-intel-mid.c
@@ -0,0 +1,163 @@
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/leds.h>
+
+#include <linux/mmc/host.h>
+
+#include "sdhci.h"
+
+/*
+ *	Support code for SDHCI on Intel MID platforms. We have lots
+ * 	of quirks specific to these platforms so wrap them up in one place
+ *	that keeps them out of the main flow. We can't just make it a new
+ *	driver as the shdci core code isn't really a library.
+ */
+ 
+static void sdhci_broken_reset(struct sdhci_host *host, u8 mask)
+{
+	unsigned long timeout;
+	u32 uninitialized_var(ier);
+
+	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
+		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
+			SDHCI_CARD_PRESENT))
+			return;
+	}
+
+	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
+		ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+
+	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+
+	if (mask & SDHCI_RESET_ALL)
+		host->clock = 0;
+
+	/* Wait max 100 ms */
+	timeout = 100;
+
+	/* hw clears the bit when it's done */
+	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
+		if (timeout == 0) {
+			printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
+				mmc_hostname(host->mmc), (int)mask);
+		}
+		timeout--;
+		mdelay(1);
+	}
+	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
+		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
+}
+
+static void sdhci_mid_broken_resetall(struct sdhci_host *host, int down)
+{
+	if (down)
+		sdhci_broken_reset(host, SDHCI_RESET_ALL);
+}
+
+static void sdhci_mid_init_no_reset(struct sdhci_host *host, int soft)
+{
+	u32 intmask;
+
+	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+	sdhci_writel(host,
+		intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE),
+		SDHCI_INT_STATUS);
+
+        /* Ensure any IRQ left over from pre boot time (eg from Kboot) does
+           not turn up and cause chaos */
+	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
+	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
+
+	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
+		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
+		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
+		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
+
+	if (soft) {
+		/* force clock reconfiguration */
+		host->clock = 0;
+		sdhci_set_ios(host->mmc, &host->mmc->ios);
+	}
+
+	/* disable wakeup signal during initialization */
+	sdhci_writeb(host, 0x0, SDHCI_WAKE_UP_CONTROL);
+}
+
+/*
+ * HW problem exists in LNW A3 so clock register has to be set
+ * for every command if both SDIO0 and SDIO1 are enabled.
+ */
+static void sdhci_clock_reset(struct sdhci_host *host)
+{
+	u16 clk;
+	unsigned long timeout;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 10 ms */
+	timeout = 10;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+		& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			printk(KERN_ERR "%s: Internal clock never "
+				"stabilised.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+}
+
+static void sdhci_clockreset_wcmd(struct sdhci_host *host,
+				struct mmc_command *cmd, int flags)
+{
+	sdhci_clock_reset(host);
+ 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+}
+
+static void sdhci_lnw_a3_set_ios(struct sdhci_host *host,
+					struct mmc_ios *ios, u8 ctrl)
+{
+	/*
+	 * For LNW A3, HISPD bit has to be cleared in order to
+	 * enable the 50MHz clock
+	 */
+	if (ios->timing == MMC_TIMING_SD_HS ||
+			ios->timing == MMC_TIMING_MMC_HS)
+		ctrl |= SDHCI_CTRL_HISPD;
+	else
+		ctrl &= ~SDHCI_CTRL_HISPD;
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+
+/*
+ * HW problem exists in LNW A3 which leads to fake interrupt on SDIO1 if SDIO0
+ * and SDIO1 are both enabled.
+ */
+static void sdhci_lnw_a3_unexpected_cmd(struct sdhci_host *host, u32 intmask)
+{
+}
+
+struct sdhci_ops sdhci_intel_mrst_hc = {
+	.reset = sdhci_broken_reset,
+	.init = sdhci_mid_init_no_reset,
+	.set_ios = sdhci_lnw_a3_set_ios,
+	.reset_all = sdhci_mid_broken_resetall,
+	.write_command = sdhci_clockreset_wcmd,
+	.unexpected_cmd_irq = sdhci_lnw_a3_unexpected_cmd,
+};
+EXPORT_SYMBOL_GPL(sdhci_intel_mrst_hc);
+
+
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e8aa99d..3e29e94 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -54,6 +54,8 @@ struct sdhci_pci_fixes {
 	int			(*suspend)(struct sdhci_pci_chip*,
 					pm_message_t);
 	int			(*resume)(struct sdhci_pci_chip*);
+
+	struct sdhci_ops	*host_ops;
 };
 
 struct sdhci_pci_slot {
@@ -397,6 +399,35 @@ static const struct sdhci_pci_fixes sdhci_via = {
 	.probe		= via_probe,
 };
 
+#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || defined(CONFIG_MMC_SDHCI_INTEL_MID_MODULE)
+
+/*
+ * ADMA operation is disabled for Moorestown platform due to
+ * hardware bugs.
+ */
+static int mrst_hc0_probe(struct sdhci_pci_chip *chip)
+{
+	/*
+	 * slots number is fixed here for MRST as SDIO3 is never used and has
+	 * hardware bugs.
+	 */
+	chip->num_slots = 1;
+	return 0;
+}
+
+static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
+	.quirks		= SDHCI_QUIRK_BROKEN_ADMA,
+	.probe		= mrst_hc0_probe,
+	.host_ops	= &sdhci_intel_mrst_hc,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1 = {
+	.quirks		= SDHCI_QUIRK_BROKEN_ADMA,
+	.host_ops	= &sdhci_intel_mrst_hc,
+};
+
+#endif
+
 static const struct pci_device_id pci_ids[] __devinitdata = {
 	{
 		.vendor		= PCI_VENDOR_ID_RICOH,
@@ -494,6 +525,23 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.driver_data	= (kernel_ulong_t)&sdhci_via,
 	},
 
+#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || defined(CONFIG_MMC_SDHCI_INTEL_MID_MODULE)
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MRST_SD0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc0,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MRST_SD1,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1,
+	},
+#endif
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
 	},
@@ -509,7 +557,7 @@ MODULE_DEVICE_TABLE(pci, pci_ids);
  *                                                                           *
 \*****************************************************************************/
 
-static int sdhci_pci_enable_dma(struct sdhci_host *host)
+int sdhci_pci_enable_dma(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot;
 	struct pci_dev *pdev;
@@ -533,6 +581,7 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sdhci_pci_enable_dma);
 
 static struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
@@ -687,7 +736,10 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 	slot->pci_bar = bar;
 
 	host->hw_name = "PCI";
-	host->ops = &sdhci_pci_ops;
+	if (chip->fixes->host_ops)
+		host->ops = chip->fixes->host_ops;
+	else
+		host->ops = &sdhci_pci_ops;
 	host->quirks = chip->quirks;
 
 	host->irq = pdev->irq;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f608626..9d8091a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -45,7 +45,7 @@ static void sdhci_finish_data(struct sdhci_host *);
 static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
 static void sdhci_finish_command(struct sdhci_host *);
 
-static void sdhci_dumpregs(struct sdhci_host *host)
+void sdhci_dumpregs(struct sdhci_host *host)
 {
 	printk(KERN_DEBUG DRIVER_NAME ": ============== REGISTER DUMP ==============\n");
 
@@ -87,6 +87,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 
 	printk(KERN_DEBUG DRIVER_NAME ": ===========================================\n");
 }
+EXPORT_SYMBOL_GPL(sdhci_dumpregs);
 
 /*****************************************************************************\
  *                                                                           *
@@ -94,7 +95,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
 {
 	u32 ier;
 
@@ -104,6 +105,7 @@ static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
 	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
 }
+EXPORT_SYMBOL_GPL(sdhci_clear_set_irqs);
 
 static void sdhci_unmask_irqs(struct sdhci_host *host, u32 irqs)
 {
@@ -143,6 +145,11 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	unsigned long timeout;
 	u32 uninitialized_var(ier);
 
+	if (host->ops->reset) {
+		host->ops->reset(host, mask);
+		return;
+	}
+
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
 			SDHCI_CARD_PRESENT))
@@ -176,14 +183,21 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
 }
 
-static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
+/* Down is true if we are shutting down the port */
+static void sdhci_reset_all(struct sdhci_host *host, int down)
+{
+	if (host->ops->reset_all)
+		host->ops->reset_all(host, down);
+	else
+		sdhci_reset(host, SDHCI_RESET_ALL);
+}
 
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
 	if (soft)
 		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
 	else
-		sdhci_reset(host, SDHCI_RESET_ALL);
+		sdhci_reset_all(host, 0);
 
 	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
 		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
@@ -945,7 +959,11 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (cmd->data)
 		flags |= SDHCI_CMD_DATA;
 
-	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	if (host->ops->write_command)
+		host->ops->write_command(host, cmd, flags);
+	else
+		sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
+						SDHCI_COMMAND);
 }
 
 static void sdhci_finish_command(struct sdhci_host *host)
@@ -1139,7 +1157,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -1186,9 +1204,13 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
 
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	if (host->ops->set_ios)
+		host->ops->set_ios(host, ios, ctrl);
+	else
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
-	/*
+	/*	FIXME: This can also be moved to ops->set_ios
+	 *
 	 * Some (ENE) controllers go apeshit on some ios operation,
 	 * signalling timeout and CRC errors even on CMD0. Resetting
 	 * it on each ios seems to solve the problem.
@@ -1200,6 +1222,7 @@ out:
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_ios);
 
 static int sdhci_get_ro(struct mmc_host *mmc)
 {
@@ -1383,10 +1406,13 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 	BUG_ON(intmask == 0);
 
 	if (!host->cmd) {
-		printk(KERN_ERR "%s: Got command interrupt 0x%08x even "
-			"though no command operation was in progress.\n",
-			mmc_hostname(host->mmc), (unsigned)intmask);
-		sdhci_dumpregs(host);
+		if (host->ops->unexpected_cmd_irq)
+			host->ops->unexpected_cmd_irq(host, intmask);
+		else {
+			printk(KERN_ERR "%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
+				mmc_hostname(host->mmc), (unsigned)intmask);
+			sdhci_dumpregs(host);
+		}
 		return;
 	}
 
@@ -1703,7 +1729,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (debug_quirks)
 		host->quirks = debug_quirks;
 
-	sdhci_reset(host, SDHCI_RESET_ALL);
+	sdhci_reset_all(host, 0);
 
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
@@ -1829,6 +1855,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
+	if (host->ops->set_caps)
+		host->ops->set_caps(host);
+
 	mmc->ocr_avail = 0;
 	if (caps & SDHCI_CAN_VDD_330)
 		mmc->ocr_avail |= MMC_VDD_32_33|MMC_VDD_33_34;
@@ -1881,7 +1910,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else {
 		mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
 				SDHCI_MAX_BLOCK_SHIFT;
-		if (mmc->max_blk_size >= 3) {
+		if (mmc->max_blk_size > 3) {
 			printk(KERN_WARNING "%s: Invalid maximum block size, "
 				"assuming 512 bytes\n", mmc_hostname(mmc));
 			mmc->max_blk_size = 0;
@@ -1952,7 +1981,7 @@ int sdhci_add_host(struct sdhci_host *host)
 
 #ifdef SDHCI_USE_LEDS_CLASS
 reset:
-	sdhci_reset(host, SDHCI_RESET_ALL);
+	sdhci_reset_all(host, 1);
 	free_irq(host->irq, host);
 #endif
 untasklet:
@@ -1993,7 +2022,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 #endif
 
 	if (!dead)
-		sdhci_reset(host, SDHCI_RESET_ALL);
+		sdhci_reset_all(host, 1);
 
 	free_irq(host->irq, host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d316bc7..182fcc3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -323,6 +323,17 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+
+	/* Interface hooks to allow drivers to override standard behaviour */
+	void	(*reset)(struct sdhci_host *host, u8 mask);
+	void	(*reset_all)(struct sdhci_host *host, int down);
+	void	(*init)(struct sdhci_host *host, int soft);
+	void 	(*write_command)(struct sdhci_host *host,
+				struct mmc_command *cmd, int flags);
+	void	(*set_ios)(struct sdhci_host *host,
+				struct mmc_ios *ios, u8 ctrl);
+	void	(*set_caps)(struct sdhci_host *host);
+	void	(*unexpected_cmd_irq)(struct sdhci_host *host, u32 intmask);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -427,4 +438,13 @@ extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
 extern int sdhci_resume_host(struct sdhci_host *host);
 #endif
 
+extern void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
+extern int sdhci_pci_enable_dma(struct sdhci_host *host);
+extern void sdhci_dumpregs(struct sdhci_host *host);
+extern void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
+
+/* Host function sets from driver support files */
+extern struct sdhci_ops sdhci_intel_mrst_hc;
+
+
 #endif /* __SDHCI_H */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9438660..674316e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2410,6 +2410,8 @@
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483
 #define PCI_DEVICE_ID_INTEL_82378	0x0484
+#define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
+#define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
 #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062


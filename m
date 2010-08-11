From: akpm@linux-foundation.org
Subject: [patch 035/177] mmc: make sdhci work with ricoh mmc controller
Date: Tue, 10 Aug 2010 18:01:42 -0700
Message-ID: <201008110101.o7B11g4Z027049@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42859 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab0HKB2P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:28:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, maximlevitsky@gmail.com, adq_dvb@lidskialf.net, linux-mmc@vger.kernel.org, philipl@overt.org, rjw@sisk.pl

From: Maxim Levitsky <maximlevitsky@gmail.com>

The current way of disabling it is not well tested by vendor and has all
kinds of bugs that show up on resume from ram/disk.  A very good example
is a dead SDHCI controller.

Old way of disabling is still supported by continuing to use
CONFIG_MMC_RICOH_MMC.

Based on 'http://list.drzeus.cx/pipermail/sdhci-devel/2007-December/002085.html'
Therefore most of the credit for this goes to Andrew de Quincey

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>
Acked-by: Philip Langdale <philipl@overt.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-pci.c |   41 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |    3 +-
 drivers/mmc/host/sdhci.h     |    4 +++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci-pci.c~mmc-make-sdhci-work-with-ricoh-mmc-controller drivers/mmc/host/sdhci-pci.c
--- a/drivers/mmc/host/sdhci-pci.c~mmc-make-sdhci-work-with-ricoh-mmc-controller
+++ a/drivers/mmc/host/sdhci-pci.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/device.h>
 
 #include <linux/mmc/host.h>
 
@@ -84,7 +85,30 @@ static int ricoh_probe(struct sdhci_pci_
 	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG ||
 	    chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SONY)
 		chip->quirks |= SDHCI_QUIRK_NO_CARD_NO_RESET;
+	return 0;
+}
+
+static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->caps =
+		((0x21 << SDHCI_TIMEOUT_CLK_SHIFT)
+			& SDHCI_TIMEOUT_CLK_MASK) |
+
+		((0x21 << SDHCI_CLOCK_BASE_SHIFT)
+			& SDHCI_CLOCK_BASE_MASK) |
 
+		SDHCI_TIMEOUT_CLK_UNIT |
+		SDHCI_CAN_VDD_330 |
+		SDHCI_CAN_DO_SDMA;
+	return 0;
+}
+
+static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
+{
+	/* Apply a delay to allow controller to settle */
+	/* Otherwise it becomes confused if card state changed
+		during suspend */
+	msleep(500);
 	return 0;
 }
 
@@ -95,6 +119,15 @@ static const struct sdhci_pci_fixes sdhc
 			  SDHCI_QUIRK_CLOCK_BEFORE_RESET,
 };
 
+static const struct sdhci_pci_fixes sdhci_ricoh_mmc = {
+	.probe_slot	= ricoh_mmc_probe_slot,
+	.resume		= ricoh_mmc_resume,
+	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR |
+			  SDHCI_QUIRK_CLOCK_BEFORE_RESET |
+			  SDHCI_QUIRK_NO_CARD_NO_RESET |
+			  SDHCI_QUIRK_MISSING_CAPS
+};
+
 static const struct sdhci_pci_fixes sdhci_ene_712 = {
 	.quirks		= SDHCI_QUIRK_SINGLE_POWER_WRITE |
 			  SDHCI_QUIRK_BROKEN_DMA,
@@ -374,6 +407,14 @@ static const struct pci_device_id pci_id
 	},
 
 	{
+		.vendor         = PCI_VENDOR_ID_RICOH,
+		.device         = 0x843,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_ENE,
 		.device		= PCI_DEVICE_ID_ENE_CB712_SD,
 		.subvendor	= PCI_ANY_ID,
diff -puN drivers/mmc/host/sdhci.c~mmc-make-sdhci-work-with-ricoh-mmc-controller drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~mmc-make-sdhci-work-with-ricoh-mmc-controller
+++ a/drivers/mmc/host/sdhci.c
@@ -1687,7 +1687,8 @@ int sdhci_add_host(struct sdhci_host *ho
 			host->version);
 	}
 
-	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
+		sdhci_readl(host, SDHCI_CAPABILITIES);
 
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff -puN drivers/mmc/host/sdhci.h~mmc-make-sdhci-work-with-ricoh-mmc-controller drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~mmc-make-sdhci-work-with-ricoh-mmc-controller
+++ a/drivers/mmc/host/sdhci.h
@@ -240,6 +240,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+/* Controller is missing device caps. Use caps provided by host */
+#define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -292,6 +294,8 @@ struct sdhci_host {
 
 	struct timer_list	timer;		/* Timer for timeouts */
 
+	unsigned int		caps;		/* Alternative capabilities */
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
_

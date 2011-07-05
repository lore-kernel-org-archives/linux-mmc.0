From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 2/3] eSDHC: Fix errors when booting kernel with fsl esdhc
Date: Tue, 5 Jul 2011 12:19:02 +0800
Message-ID: <1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:30250
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752770Ab1GEDkx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 23:40:53 -0400
In-Reply-To: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, akpm@linux-foundation.org, Xu lei <B33228@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

From: Xu lei <B33228@freescale.com>

When esdhc module was enabled in p5020, there were following errors:

mmc0: Timeout waiting for hardware interrupt.
mmc0: error -110 whilst initialising SD card
mmc0: Unexpected interrupt 0x02000000.
mmc0: Timeout waiting for hardware interrupt.
mmc0: error -110 whilst initialising SD card
mmc0: Unexpected interrupt 0x02000000.

It is because ESDHC controller has different bit setting for PROCTL
register, when kernel sets Power Control Register by method for standard
SD Host Specification, it would overwritten FSL ESDHC PROCTL[DMAS];
when it set Host Control Registers[DMAS], it sets PROCTL[EMODE] and
PROCTL[D3CD]. These operations will set bad bits for PROCTL Register
on FSL ESDHC Controller and cause errors, so this patch will make esdhc
driver access FSL PROCTL Register according to block guide instead of
standard SD Host Specification.

For some FSL chips, such as MPC8536/P2020, PROCTL[VOLT_SEL] and PROCTL[DMAS]
bits are reserved and even if they are set to wrong bits there is no error.
But considering that all FSL ESDHC Controller register map is not fully
compliant to standard SD Host Specification, we put the patch to all of
FSL ESDHC Controllers.

Signed-off-by: Lei Xu <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/mmc/host/sdhci-of-core.c |    3 ++
 drivers/mmc/host/sdhci.c         |   62 ++++++++++++++++++++++++++++++-------
 include/linux/mmc/sdhci.h        |    6 ++-
 3 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index 60e4186..fede43d 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -179,6 +179,9 @@ static int __devinit sdhci_of_probe(struct platform_device *ofdev)
 	if (sdhci_of_wp_inverted(np))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+	if (of_device_is_compatible(np, "fsl,esdhc"))
+		host->quirks |= SDHCI_QUIRK_QORIQ_PROCTL_WEIRD;
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = be32_to_cpup(clk);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 58d5436..77174e5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -674,7 +674,7 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
-	u8 ctrl;
+	u32 ctrl;
 	struct mmc_data *data = cmd->data;
 	int ret;
 
@@ -807,14 +807,28 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	 * is ADMA.
 	 */
 	if (host->version >= SDHCI_SPEC_200) {
-		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-		ctrl &= ~SDHCI_CTRL_DMA_MASK;
-		if ((host->flags & SDHCI_REQ_USE_DMA) &&
-			(host->flags & SDHCI_USE_ADMA))
-			ctrl |= SDHCI_CTRL_ADMA32;
-		else
-			ctrl |= SDHCI_CTRL_SDMA;
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+		if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD) {
+#define ESDHCI_PROCTL_DMAS_MASK		0x00000300
+#define ESDHCI_PROCTL_ADMA32		0x00000200
+#define ESDHCI_PROCTL_SDMA		0x00000000
+			ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
+			ctrl &= ~ESDHCI_PROCTL_DMAS_MASK;
+			if ((host->flags & SDHCI_REQ_USE_DMA) &&
+				(host->flags & SDHCI_USE_ADMA))
+				ctrl |= ESDHCI_PROCTL_ADMA32;
+			else
+				ctrl |= ESDHCI_PROCTL_SDMA;
+			sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
+		} else {
+			ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+			ctrl &= ~SDHCI_CTRL_DMA_MASK;
+			if ((host->flags & SDHCI_REQ_USE_DMA) &&
+				(host->flags & SDHCI_USE_ADMA))
+				ctrl |= SDHCI_CTRL_ADMA32;
+			else
+				ctrl |= SDHCI_CTRL_SDMA;
+			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+		}
 	}
 
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
@@ -1138,19 +1152,32 @@ out:
 static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr = 0;
+	u8 volt = 0;
 
 	if (power != (unsigned short)-1) {
 		switch (1 << power) {
+#define	ESDHCI_FSL_POWER_MASK	0x40
+#define	ESDHCI_FSL_POWER_180	0x00
+#define	ESDHCI_FSL_POWER_300	0x40
 		case MMC_VDD_165_195:
-			pwr = SDHCI_POWER_180;
+			if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD)
+				pwr = ESDHCI_FSL_POWER_180;
+			else
+				pwr = SDHCI_POWER_180;
 			break;
 		case MMC_VDD_29_30:
 		case MMC_VDD_30_31:
-			pwr = SDHCI_POWER_300;
+			if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD)
+				pwr = ESDHCI_FSL_POWER_300;
+			else
+				pwr = SDHCI_POWER_300;
 			break;
 		case MMC_VDD_32_33:
 		case MMC_VDD_33_34:
-			pwr = SDHCI_POWER_330;
+			if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD)
+				pwr = ESDHCI_FSL_POWER_300;
+			else
+				pwr = SDHCI_POWER_330;
 			break;
 		default:
 			BUG();
@@ -1162,6 +1189,17 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 
 	host->pwr = pwr;
 
+	/* Now FSL ESDHC Controller has no Bus Power bit,
+	 * and PROCTL[21] bit is for voltage selection */
+	if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD) {
+		volt = sdhci_readb(host, SDHCI_POWER_CONTROL);
+		volt &= ~ESDHCI_FSL_POWER_MASK;
+		volt |= pwr;
+		sdhci_writeb(host, volt, SDHCI_POWER_CONTROL);
+
+		return;
+	}
+
 	if (pwr == 0) {
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 		return;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 6a68c4e..d87abc7 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -21,7 +21,7 @@ struct sdhci_host {
 	/* Data set by hardware interface driver */
 	const char *hw_name;	/* Hardware bus name */
 
-	unsigned int quirks;	/* Deviations from spec. */
+	u64 quirks;	/* Deviations from spec. */
 
 /* Controller doesn't honor resets unless we touch the clock register */
 #define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
@@ -86,7 +86,9 @@ struct sdhci_host {
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
 /* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
-#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
+#define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1U<<31)
+/* Controller has weird bit setting for Protocol Control Register */
+#define SDHCI_QUIRK_QORIQ_PROCTL_WEIRD			(0x100000000U)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.6.0.6



From: <r66093@freescale.com>
Subject: [PATCH 5/5 v2] ESDHC: Fix DMA errors in kernel booting on P1010
Date: Thu, 22 Dec 2011 18:22:01 +0800
Message-ID: <1324549321-30796-5-git-send-email-r66093@freescale.com>
References: <1324549321-30796-1-git-send-email-r66093@freescale.com>
 <1324549321-30796-2-git-send-email-r66093@freescale.com>
 <1324549321-30796-3-git-send-email-r66093@freescale.com>
 <1324549321-30796-4-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:33103
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755152Ab1LVLJw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2011 06:09:52 -0500
In-Reply-To: <1324549321-30796-4-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

When linux is booted with DMA mode enabled in esdhc module on P1010,
there were following errors:

mmc0: ADMA error
mmc0: error -5 whilst initialising SD card

It is because FSL ESDHC controller has different bit setting for PROCTL
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

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- change the property to compatible for quirks

 drivers/mmc/host/sdhci-pltfm.c |    3 ++
 drivers/mmc/host/sdhci.c       |   61 ++++++++++++++++++++++++++++++++-------
 include/linux/mmc/sdhci.h      |    2 +
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 44aeebb..01d6df5 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -86,6 +86,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "fsl,p1010-esdhc"))
 			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
 
+		if (of_device_is_compatible(np, "fsl,esdhc"))
+			host->quirks2 |= SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD;
+
 #ifdef CONFIG_PM
 		if (of_device_is_compatible(np, "fsl,p1022-esdhc")
 			sdhc_pmsaveproctlreg = 1;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5168127..ded80e5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -832,14 +832,29 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
+		if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD) {
+#define ESDHCI_PROCTL_DMAS_MASK		0x00000300
+#define ESDHCI_PROCTL_ADMA32		0x00000200
+#define ESDHCI_PROCTL_SDMA		0x00000000
+			u32 ctrl;
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
@@ -1165,17 +1180,29 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	u8 pwr = 0;
 
 	if (power != (unsigned short)-1) {
+#define	ESDHCI_FSL_POWER_MASK	0x40
+#define	ESDHCI_FSL_POWER_180	0x00
+#define	ESDHCI_FSL_POWER_300	0x40
 		switch (1 << power) {
 		case MMC_VDD_165_195:
-			pwr = SDHCI_POWER_180;
+			if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD)
+				pwr = ESDHCI_FSL_POWER_180;
+			else
+				pwr = SDHCI_POWER_180;
 			break;
 		case MMC_VDD_29_30:
 		case MMC_VDD_30_31:
-			pwr = SDHCI_POWER_300;
+			if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD)
+				pwr = ESDHCI_FSL_POWER_300;
+			else
+				pwr = SDHCI_POWER_300;
 			break;
 		case MMC_VDD_32_33:
 		case MMC_VDD_33_34:
-			pwr = SDHCI_POWER_330;
+			if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD)
+				pwr = ESDHCI_FSL_POWER_300;
+			else
+				pwr = SDHCI_POWER_330;
 			break;
 		default:
 			BUG();
@@ -1185,6 +1212,18 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	if (host->pwr == pwr)
 		return;
 
+	/* Now FSL ESDHC Controller has no Bus Power bit,
+	 * and PROCTL[21] bit is for voltage selection */
+	if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD) {
+		u8 volt = 0;
+		volt = sdhci_readb(host, SDHCI_POWER_CONTROL);
+		volt &= ~ESDHCI_FSL_POWER_MASK;
+		volt |= pwr;
+		sdhci_writeb(host, volt, SDHCI_POWER_CONTROL);
+
+		return;
+	}
+
 	host->pwr = pwr;
 
 	if (pwr == 0) {
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index f7c1e13..d025134 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -93,6 +93,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
 /* Controller operates the cards at reduced frequency */
 #define SDHCI_QUIRK2_RELAX_FREQ				(1<<1)
+/* Controller has weird bit setting for Protocol Control Register */
+#define SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD			(1<<2)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.5.4



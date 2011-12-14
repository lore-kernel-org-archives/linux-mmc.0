From: <r66093@freescale.com>
Subject: [PATCH 6/6] ESDHC: Fix DMA errors in kernel booting on P1010
Date: Wed, 14 Dec 2011 10:19:42 +0800
Message-ID: <1323829182-1551-7-git-send-email-r66093@freescale.com>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <1323829182-1551-3-git-send-email-r66093@freescale.com>
 <1323829182-1551-4-git-send-email-r66093@freescale.com>
 <1323829182-1551-5-git-send-email-r66093@freescale.com>
 <1323829182-1551-6-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:38878 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab1LNDFx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 22:05:53 -0500
Received: from mail176-tx2 (localhost [127.0.0.1])	by
 mail176-tx2-R.bigfish.com (Postfix) with ESMTP id 794A72C00B5	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:54 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.251])	by
 mail176-tx2.bigfish.com (Postfix) with ESMTP id 1C3CA220046	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:54 +0000 (UTC)
In-Reply-To: <1323829182-1551-6-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>

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
---
 drivers/mmc/host/sdhci-pltfm.c |    4 ++
 drivers/mmc/host/sdhci.c       |   61 ++++++++++++++++++++++++++++++++-------
 include/linux/mmc/sdhci.h      |    2 +
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 8ece860..103abe9 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -86,6 +86,10 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 		if (of_get_property(np, "sdhci,relax-freq", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
+
+		if (of_device_is_compatible(np, "fsl,esdhc"))
+			host->quirks2 |= SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD;
+
 #ifdef CONFIG_PM
 		if (of_get_property(np, "pmsaveproctlreg", NULL))
 			sdhc_pmsaveproctlreg = 1;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ae52ab9..eccaaf4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -837,14 +837,29 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
@@ -1170,17 +1185,29 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
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
@@ -1190,6 +1217,18 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
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
index b5f9559..e1331d6 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -95,6 +95,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS		(1<<1)
 /* Controller operates the cards at reduced frequency */
 #define SDHCI_QUIRK2_RELAX_FREQ				(1<<2)
+/* Controller has weird bit setting for Protocol Control Register */
+#define SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD			(1<<3)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.5.4



From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH][upstream] eSDHC: fix errors when booting kernel on Freescale eSDHC version 2.3
Date: Fri, 13 Jan 2012 15:02:01 +0800
Message-ID: <1326438121-26732-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:35629
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751595Ab2AMGMP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 01:12:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Roy Zang <tie-fei.zang@freescale.com>, Lei Xu <B33228@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Priyanka Jain <Priyanka.Jain@freescale.com>

From: Roy Zang <roy@royamd64.(none)>

When eSDHC module is enabled on P5020/P3041/P2041/P1010 with eSDHC
version 2.3, there is following errors:

mmc0: Timeout waiting for hardware interrupt.
mmc0: error -110 whilst initialising SD card
mmc0: Unexpected interrupt 0x02000000.
mmc0: Timeout waiting for hardware interrupt.
mmc0: error -110 whilst initialising SD card
mmc0: Unexpected interrupt 0x02000000.

It is because eSDHC controller has different bit setting for PROCTL
register at 0x28 comparing SD specification.
This patch sets DMAS bits correctly for byte operation and does not
change the default value of other field of PROCTL register.

For other FSL chips, such as MPC8536/P2020, PROCTL[DMAS]
bits are reserved and even if they are set to wrong bits, it will not
take effective.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Cc: Lei Xu <B33228@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>
---
this is a replacemnet patch for 
http://patchwork.ozlabs.org/patch/103184/
or
http://permalink.gmane.org/gmane.linux.kernel.mmc/12066

according to feedback
http://article.gmane.org/gmane.linux.kernel.mmc/12072/match=c+must+know+nothing+esdhc+registers
and 
http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-August/092402.html

Tested on P3041/P5020 and P4080
 drivers/mmc/host/sdhci-of-esdhc.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 01e5f62..36caad3 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -38,6 +38,22 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
 	int base = reg & ~0x3;
 	int shift = (reg & 0x3) * 8;
 	u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
+
+	/*
+	 * "DMA select" locates at offset 0x28 in SD specification, but on
+	 * P5020 or P3041, it locates at 0x29.
+	 */
+	if (reg == SDHCI_HOST_CONTROL) {
+		u32 dma_bits;
+		dma_bits = in_be32(host->ioaddr + reg);
+		/* DMA select is 22,23 bits in Protocol Control Register*/
+		dma_bits = (dma_bits >> 5) & SDHCI_CTRL_DMA_MASK;
+
+		/* fixup the result */
+		ret &= ~SDHCI_CTRL_DMA_MASK;
+		ret |= dma_bits;
+	}
+
 	return ret;
 }
 
@@ -56,6 +72,20 @@ static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
 
 static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 {
+	/*
+	 * "DMA select" locates at offset 0x28 in SD specification, but on
+	 * P5020 or P3041, it locates at 0x29.
+	 */
+	if (reg == SDHCI_HOST_CONTROL) {
+		u32 dma_bits;
+		/* DMA select is 22,23 bits in Protocol Control Register*/
+		dma_bits = (val & SDHCI_CTRL_DMA_MASK) << 5;
+		clrsetbits_be32(host->ioaddr + reg , SDHCI_CTRL_DMA_MASK << 5,
+			dma_bits);
+		val &= ~SDHCI_CTRL_DMA_MASK;
+		val |= (in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK);
+	}
+
 	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
 	if (reg == SDHCI_HOST_CONTROL)
 		val &= ~ESDHC_HOST_CONTROL_RES;
-- 
1.7.0.4



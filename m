From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Fri, 26 Aug 2011 16:01:48 +0530
Message-ID: <CANYdXno+b6ZZ=3upGMwYxxbJMbKSteWKGM=RxtKhSOYr3iov4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61703 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab1HZKbt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2011 06:31:49 -0400
Received: by gwaa12 with SMTP id a12so2681561gwa.19
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2011 03:31:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Wil

This Patch adds the support for Dual Buffer Descriptor mode of
Operation for the dw_mmc driver.The patch also provides the configurability
Option for choosing DUAL_BUFFER mode or the chained modes through menuconfig.
The Menuconfig option for selecting Dual Buffer mode or chained mode
is selected only if
Internal DMAC is enabled.

Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
 drivers/mmc/host/Kconfig  |   22 ++++++++++++++++++
 drivers/mmc/host/dw_mmc.c |   55 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c87096..e10f585 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -534,6 +534,28 @@ config MMC_DW_IDMAC
 	  Designware Mobile Storage IP block. This disables the external DMA
 	  interface.

+config IDMAC_DESC_MODE
+	bool "Internal DMAC Descriptor Operating Mode"
+	depends on MMC_DW_IDMAC
+	help
+	  This selects the Operating mode for the Descriptors.
+
+choice
+	prompt "select configuration"
+	depends on IDMAC_DESC_MODE
+
+config CHAIN_DESC
+	bool "Chain Descriptor Structure"
+	help
+	  Select this option to enable Chained Mode of Operation.
+
+config DUAL_BUFFER_DESC
+	bool "Dual Buffer Descriptor Structure"
+	help
+	  Select this option to enable Dual Buffer Desc Mode of Operation.
+endchoice
+
+
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
 	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0f714..a590856 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -63,6 +63,9 @@ struct idmac_desc {
 	u32		des1;	/* Buffer sizes */
 #define IDMAC_SET_BUFFER1_SIZE(d, s) \
 	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
+#define IDMAC_SET_BUFFER_SIZE(d, s1, s2) \
+	((d)->des1 = ((d)->des1 & 0x0) | \
+	(((s1) & 0x1fff) | ((s2) & 0x1fff << 13)))

 	u32		des2;	/* buffer 1 physical address */

@@ -348,17 +351,44 @@ static void dw_mci_translate_sglist(struct
dw_mci *host, struct mmc_data *data,
 	struct idmac_desc *desc = host->sg_cpu;

 	for (i = 0; i < sg_len; i++, desc++) {
-		unsigned int length = sg_dma_len(&data->sg[i]);
-		u32 mem_addr = sg_dma_address(&data->sg[i]);
-
-		/* Set the OWN bit and disable interrupts for this descriptor */
+		/*length and mem_aadress of first buffer*/
+		unsigned int length1 = sg_dma_len(&data->sg[i]);
+		u32 mem_addr1 = sg_dma_address(&data->sg[i]);
+#ifdef CONFIG_DUAL_BUFFER_DESC
+		unsigned int length2;
+		u32 mem_addr2;
+		if ((i+1) <= sg_len) {
+			length2 = sg_dma_len(&data->sg[i+1]);
+			mem_addr2 = sg_dma_address(&data->sg[i+1]);
+
+			/* Set the OWN bit and disable interrupts
+			 * for this descriptor
+			 */
+			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC
+			desc->des0 &= (~IDMAC_DES0_CH);
+			/* Buffer length being set for Buffer1
+			 * and Buffer2 being set
+			 */
+			IDMAC_SET_BUFFER_SIZE(desc, length1, length2);
+			desc->des3 = mem_addr2;
+			/* Incrementing for the second buffer */
+			i++;
+		} else {
+			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC
+			desc->des0 &= (~IDMAC_DES0_CH);
+			/* Buffer length being set for Buffer1
+			 * and Buffer2 being set
+			 */
+			IDMAC_SET_BUFFER_SIZE(desc, length1, 0);
+		}
+#elif CONFIG_CHAIN_DESC
+		/* Set OWN bit and disable interrupts for this descriptor */
 		desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
-
-		/* Buffer length */
-		IDMAC_SET_BUFFER1_SIZE(desc, length);
-
+		/* Buffer length for Buffer1*/
+		IDMAC_SET_BUFFER1_SIZE(desc, length1);
+#endif
 		/* Physical address to DMA to/from */
-		desc->des2 = mem_addr;
+		desc->des2 = mem_addr1;
 	}

 	/* Set first descriptor */
@@ -369,6 +399,10 @@ static void dw_mci_translate_sglist(struct dw_mci
*host, struct mmc_data *data,
 	desc = host->sg_cpu + (i - 1) * sizeof(struct idmac_desc);
 	desc->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
 	desc->des0 |= IDMAC_DES0_LD;
+#ifdef CONFIG_DUAL_BUFFER_DESC
+	/*Set the End of Ring bit */
+	desc->des0 |= IDMAC_DES0_ER;
+#endif

 	wmb();
 }
@@ -388,7 +422,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci
*host, unsigned int sg_len)

 	/* Enable the IDMAC */
 	temp = mci_readl(host, BMOD);
-	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
+	/* The Descriptor Skip length is made zero */
+	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB & SDMMC_BMOD_DSL(0);
 	mci_writel(host, BMOD, temp);

 	/* Start it running */
-- 
1.7.2.3


-- 
regards,
Shashidhar Hiremath

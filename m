From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: [PATCH v2 1/1] mmc: dw_mmc: Add IDMAC 64-bit address mode support
Date: Tue, 13 Aug 2013 13:23:42 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2CD76FE@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:34496 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757753Ab3HMNXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Aug 2013 09:23:49 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Wei WANG <wei_wang@realsil.com.cn>, Ludovic Desroches <ludovic.desroches@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "prabu.t@synopsys.com" <prabu.t@synopsys.com>

Synopsys DW_MMC IP core supports Internal DMA Controller
with 64-bit address mode from IP version 2.70a onwards.
For 64-bit address mode, IP has new registers and different offset
for some of the registers which were used in 32-bit address mode.
Added driver modifications under the macro CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
to support IDMAC 64-bit address mode.

Tested the features in DW_MMC IP core v2.70a with HAPS-51 setup and driver is working fine.

Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
---
Change log v2:
	-Add the configuration.

 drivers/mmc/host/Kconfig  |    9 ++++
 drivers/mmc/host/dw_mmc.c |  106 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h |   11 +++++
 3 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8a4c066..a5ef53f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -544,6 +544,15 @@ config MMC_DW_IDMAC
 	  Designware Mobile Storage IP block. This disables the external DMA
 	  interface.
 
+config MMC_DW_IDMAC_64BIT_ADDRESS
+	bool "Internal DMAC with 64-bit address support"
+	depends on MMC_DW_IDMAC
+	help
+	  This selects support for the internal DMA controller with 64-bit
+	  address mode driver. This should be enabled only if the IP
+	  supports internal DMA controller block with 64-bit addressing
+	  mode.
+
 config MMC_DW_PLTFM
 	tristate "Synopsys Designware MCI Support as platform device"
 	depends on MMC_DW
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ee5f167..de60f61 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -55,7 +55,31 @@
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
 				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
 				 SDMMC_IDMAC_INT_TI)
+#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+struct idmac_desc64 {
+	u32		des0;	/* Control Descriptor */
+#define IDMAC_DES0_DIC	BIT(1)
+#define IDMAC_DES0_LD	BIT(2)
+#define IDMAC_DES0_FD	BIT(3)
+#define IDMAC_DES0_CH	BIT(4)
+#define IDMAC_DES0_ER	BIT(5)
+#define IDMAC_DES0_CES	BIT(30)
+#define IDMAC_DES0_OWN	BIT(31)
+
+	u32		des1;	/* Reserved */
 
+	u32		des2;	/* Buffer sizes */
+#define IDMAC_SET_BUFFER1_SIZE(d, s) \
+	((d)->des2 = ((d)->des2 & 0x03ffe000) | ((s) & 0x1fff))
+
+	u32		des3;	/* Reserved */
+
+	u32		des4;	/* Lower 32-bits of Buffer Address Pointer 1*/
+	u32		des5;	/* Upper 32-bits of Buffer Address Pointer 1*/
+	u32		des6;	/* Lower 32-bits of Next Descriptor Address */
+	u32		des7;	/* Upper 32-bits of Next Descriptor Address */
+};
+#else
 struct idmac_desc {
 	u32		des0;	/* Control Descriptor */
 #define IDMAC_DES0_DIC	BIT(1)
@@ -74,6 +98,7 @@ struct idmac_desc {
 
 	u32		des3;	/* buffer 2 physical address */
 };
+#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
 #endif /* CONFIG_MMC_DW_IDMAC */
 
 /**
@@ -365,6 +390,40 @@ static void dw_mci_idmac_complete_dma(struct dw_mci *host)
 	}
 }
 
+#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
+				    unsigned int sg_len)
+{
+	int i;
+	struct idmac_desc64 *desc = host->sg_cpu;
+
+	for (i = 0; i < sg_len; i++, desc++) {
+		unsigned int length = sg_dma_len(&data->sg[i]);
+		u64 mem_addr = sg_dma_address(&data->sg[i]);
+
+		/* Set the OWN bit and disable interrupts for this descriptor */
+		desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
+
+		/* Buffer length */
+		IDMAC_SET_BUFFER1_SIZE(desc, length);
+
+		/* Physical address to DMA to/from */
+		desc->des4 = mem_addr & 0xffffffff;
+		desc->des5 = mem_addr >> 32;
+	}
+
+	/* Set first descriptor */
+	desc = host->sg_cpu;
+	desc->des0 |= IDMAC_DES0_FD;
+
+	/* Set last descriptor */
+	desc = host->sg_cpu + (i - 1) * sizeof(struct idmac_desc64);
+	desc->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
+	desc->des0 |= IDMAC_DES0_LD;
+
+	wmb();
+}
+#else
 static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 				    unsigned int sg_len)
 {
@@ -396,6 +455,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 
 	wmb();
 }
+#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
 
 static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 {
@@ -419,6 +479,40 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 	mci_writel(host, PLDMND, 1);
 }
 
+#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+static int dw_mci_idmac_init(struct dw_mci *host)
+{
+	struct idmac_desc64 *p;
+	int i;
+
+	/* Number of descriptors in the ring buffer */
+	host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc64);
+
+	/* Forward link the descriptor list */
+	for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++) {
+		p->des6 = (host->sg_dma + (sizeof(struct idmac_desc64) *
+						(i + 1))) & 0xffffffff;
+		p->des7 = (host->sg_dma + (sizeof(struct idmac_desc64) *
+						(i + 1))) >> 32;
+	}
+
+	/* Set the last descriptor as the end-of-ring descriptor */
+	p->des6 = host->sg_dma & 0xffffffff;
+	p->des7 = host->sg_dma >> 32;
+	p->des0 = IDMAC_DES0_ER;
+
+	mci_writel(host, BMOD, SDMMC_IDMAC_SWRESET);
+
+	/* Mask out interrupts - get Tx & Rx complete only */
+	mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI | SDMMC_IDMAC_INT_RI |
+		   SDMMC_IDMAC_INT_TI);
+
+	/* Set the descriptor base address */
+	mci_writel(host, DBADDRL, host->sg_dma & 0xffffffff);
+	mci_writel(host, DBADDRU, host->sg_dma >> 32);
+	return 0;
+}
+#else
 static int dw_mci_idmac_init(struct dw_mci *host)
 {
 	struct idmac_desc *p;
@@ -446,6 +540,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	mci_writel(host, DBADDR, host->sg_dma);
 	return 0;
 }
+#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
 
 static const struct dw_mci_dma_ops dw_mci_idmac_ops = {
 	.init = dw_mci_idmac_init,
@@ -2036,6 +2131,17 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 
 static void dw_mci_init_dma(struct dw_mci *host)
 {
+	u32 addr_config;
+	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
+	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
+	if (addr_config) {
+		dev_info(host->dev, "IDMAC with 64-bit address mode.\n");
+		if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
+			dma_set_coherent_mask(host->dev, DMA_BIT_MASK(64));
+		else
+			goto no_dma;
+	}
+
 	/* Alloc memory for sg translation */
 	host->sg_cpu = dmam_alloc_coherent(host->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 81b2994..a3a5e9c 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -48,11 +48,22 @@
 #define SDMMC_UHS_REG		0x074
 #define SDMMC_BMOD		0x080
 #define SDMMC_PLDMND		0x084
+#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+#define SDMMC_DBADDRL		0x088
+#define SDMMC_DBADDRU		0x08c
+#define SDMMC_IDSTS		0x090
+#define SDMMC_IDINTEN		0x094
+#define SDMMC_DSCADDRL		0x098
+#define SDMMC_DSCADDRU		0x09c
+#define SDMMC_BUFADDRL		0x0A0
+#define SDMMC_BUFADDRU		0x0A4
+#else
 #define SDMMC_DBADDR		0x088
 #define SDMMC_IDSTS		0x08c
 #define SDMMC_IDINTEN		0x090
 #define SDMMC_DSCADDR		0x094
 #define SDMMC_BUFADDR		0x098
+#endif
 #define SDMMC_DATA(x)		(x)
 
 /*
-- 
1.7.6.5

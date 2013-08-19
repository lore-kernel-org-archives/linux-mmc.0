From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: RE: [PATCH v3 1/1] mmc: dw_mmc: Add IDMAC 64-bit address mode
 support
Date: Mon, 19 Aug 2013 10:27:00 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2CD7D78@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:64094 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3HSK1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Aug 2013 06:27:07 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Wei WANG <wei_wang@realsil.com.cn>, Ludovic Desroches <ludovic.desroches@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "prabu.t@synopsys.com" <prabu.t@synopsys.com>

Synopsys DW_MMC IP core supports Internal DMA Controller with 64-bit address mode from IP version 2.70a onwards.
For 64-bit address mode, IP has new registers and different offset for some of the registers which were used in 32-bit address mode.
Added driver modifications under the macro CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS to support IDMAC 64-bit address mode.

Tested the features in DW_MMC IP core v2.70a with HAPS-51 setup and driver is working fine.

Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
---
Change log v3:
	-Add the condition check to find the IDMAC configuration mismatches between sw & hw.
	-Driver should not use the IDMAC if any conflict between sw & hw configurations
	 since the register offsets are different for both 32-bit and 64-bit configurations.
	-Reused the existing code.
	
Change log v2:
	-Add the configuration.

 drivers/mmc/host/Kconfig  |    9 ++++
 drivers/mmc/host/dw_mmc.c |   98 +++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.h |   11 +++++
 3 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8a4c066..c6186b9 100644
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
index ee5f167..5eb0102 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -55,7 +55,6 @@
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
 				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
 				 SDMMC_IDMAC_INT_TI)
-
 struct idmac_desc {
 	u32		des0;	/* Control Descriptor */
 #define IDMAC_DES0_DIC	BIT(1)
@@ -66,6 +65,20 @@ struct idmac_desc {
 #define IDMAC_DES0_CES	BIT(30)
 #define IDMAC_DES0_OWN	BIT(31)
 
+#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+	u32	des1;	/* Reserved */
+
+	u32	des2;	/* Buffer sizes */
+#define IDMAC_SET_BUFFER1_SIZE(d, s) \
+	((d)->des2 = ((d)->des2 & 0x03ffe000) | ((s) & 0x1fff))
+
+	u32	des3;	/* Reserved */
+
+	u32	des4;	/* Lower 32-bits of Buffer Address Pointer 1*/
+	u32	des5;	/* Upper 32-bits of Buffer Address Pointer 1*/
+	u32	des6;	/* Lower 32-bits of Next Descriptor Address */
+	u32	des7;	/* Upper 32-bits of Next Descriptor Address */
+#else
 	u32		des1;	/* Buffer sizes */
 #define IDMAC_SET_BUFFER1_SIZE(d, s) \
 	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
@@ -73,6 +86,7 @@ struct idmac_desc {
 	u32		des2;	/* buffer 1 physical address */
 
 	u32		des3;	/* buffer 2 physical address */
+#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
 };
 #endif /* CONFIG_MMC_DW_IDMAC */
 
@@ -373,7 +387,11 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 
 	for (i = 0; i < sg_len; i++, desc++) {
 		unsigned int length = sg_dma_len(&data->sg[i]);
+		#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+		u64 mem_addr = sg_dma_address(&data->sg[i]);
+		#else
 		u32 mem_addr = sg_dma_address(&data->sg[i]);
+		#endif
 
 		/* Set the OWN bit and disable interrupts for this descriptor */
 		desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
@@ -381,8 +399,14 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 		/* Buffer length */
 		IDMAC_SET_BUFFER1_SIZE(desc, length);
 
+		#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+		/* Physical address to DMA to/from */
+		desc->des4 = mem_addr & 0xffffffff;
+		desc->des5 = mem_addr >> 32;
+		#else
 		/* Physical address to DMA to/from */
 		desc->des2 = mem_addr;
+		#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
 	}
 
 	/* Set first descriptor */
@@ -396,7 +420,6 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 
 	wmb();
 }
-
 static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 {
 	u32 temp;
@@ -427,12 +450,27 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	/* Number of descriptors in the ring buffer */
 	host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
 
+	#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+	/* Forward link the descriptor list */
+	for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++) {
+		p->des6 = (host->sg_dma + (sizeof(struct idmac_desc) *
+						(i + 1))) & 0xffffffff;
+		p->des7 = (host->sg_dma + (sizeof(struct idmac_desc) *
+						(i + 1))) >> 32;
+	}
+
+	/* Set the last descriptor as the end-of-ring descriptor */
+	p->des6 = host->sg_dma & 0xffffffff;
+	p->des7 = host->sg_dma >> 32;
+	#else
 	/* Forward link the descriptor list */
 	for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
 		p->des3 = host->sg_dma + (sizeof(struct idmac_desc) * (i + 1));
 
 	/* Set the last descriptor as the end-of-ring descriptor */
 	p->des3 = host->sg_dma;
+	#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
+
 	p->des0 = IDMAC_DES0_ER;
 
 	mci_writel(host, BMOD, SDMMC_IDMAC_SWRESET);
@@ -442,8 +480,15 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	mci_writel(host, IDINTEN, SDMMC_IDMAC_INT_NI | SDMMC_IDMAC_INT_RI |
 		   SDMMC_IDMAC_INT_TI);
 
+	#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+	/* Set the descriptor base address */
+	mci_writel(host, DBADDRL, host->sg_dma & 0xffffffff);
+	mci_writel(host, DBADDRU, host->sg_dma >> 32);
+	#else
 	/* Set the descriptor base address */
 	mci_writel(host, DBADDR, host->sg_dma);
+	#endif /* CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS */
+
 	return 0;
 }
 
@@ -1977,11 +2022,22 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	} else {
 		/* Useful defaults if platform data is unset. */
 #ifdef CONFIG_MMC_DW_IDMAC
-		mmc->max_segs = host->ring_size;
-		mmc->max_blk_size = 65536;
-		mmc->max_blk_count = host->ring_size;
-		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
+		if (host->use_dma == 1) {
+			mmc->max_segs = host->ring_size;
+			mmc->max_blk_size = 65536;
+			mmc->max_blk_count = host->ring_size;
+			mmc->max_seg_size = 0x1000;
+			mmc->max_req_size = mmc->max_seg_size *
+							mmc->max_blk_count;
+		} else {
+			/* Useful if any conflict between sw & hw config. */
+			mmc->max_segs = 64;
+			mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
+			mmc->max_blk_count = 512;
+			mmc->max_req_size = mmc->max_blk_size *
+							mmc->max_blk_count;
+			mmc->max_seg_size = mmc->max_req_size;
+		}
 #else
 		mmc->max_segs = 64;
 		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
@@ -2036,6 +2092,34 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 
 static void dw_mci_init_dma(struct dw_mci *host)
 {
+	u32 addr_config;
+	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
+	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
+
+#ifdef CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS
+	if (addr_config == 1) {
+		dev_info(host->dev, "IDMAC supports 64-bit address mode.\n");
+		if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
+			dma_set_coherent_mask(host->dev, DMA_BIT_MASK(64));
+	} else {
+		dev_err(host->dev,
+			"%s: Wrong IDMAC configuration,"
+			" H/W doesn't support IDMAC 64-bit address mode!\n",
+			__func__);
+		goto no_dma;
+	}
+#else
+	if (addr_config == 0) {
+		dev_info(host->dev, "IDMAC supports 32-bit address mode.\n");
+	} else {
+		dev_err(host->dev,
+			"%s: Wrong IDMAC configuration,"
+			" H/W doesn't support IDMAC 32-bit address mode!\n",
+			__func__);
+		goto no_dma;
+	}
+#endif
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


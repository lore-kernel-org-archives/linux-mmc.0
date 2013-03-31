From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 4/5] mmc: mxcmmc: enable DMA support on mpc512x
Date: Mon,  1 Apr 2013 00:23:04 +0200
Message-ID: <1364768585-5177-5-git-send-email-agust@denx.de>
References: <1364768585-5177-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:46463 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab3CaWXX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Mar 2013 18:23:23 -0400
In-Reply-To: <1364768585-5177-1-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>

Add SDHC DMA channel description to the mpc512x device
tree to enable slave channel requesting in the mxcmmc
driver.

mpc512x DMA engine doesn't support endianness conversion
when reading/writing data from peripheral's FIFO, so we
have to swap data buffers before each DMA write and after
each DMA read transfer manually.

Since chained SDHC DMA transfers are not supported on
mpc512x, limit 'max_segs' tunable parameter to one and
initialise it to 64 only when running on i.MX platforms.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v2:
 - only rebased

 arch/powerpc/boot/dts/mpc5121.dtsi |    2 ++
 drivers/mmc/host/mxcmmc.c          |   35 +++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index d1fe070..712b15a 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -152,6 +152,8 @@
 			compatible = "fsl,mpc5121-sdhc";
 			reg = <0x1500 0x100>;
 			interrupts = <8 0x8>;
+			dmas = <&dma0 30>;
+			dma-names = "rx-tx";
 		};
 
 		i2c@1700 {
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index dbacbde..2861e0d 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -301,6 +301,29 @@ static void mxcmci_softreset(struct mxcmci_host *host)
 }
 static int mxcmci_setup_dma(struct mmc_host *mmc);
 
+#if IS_ENABLED(CONFIG_PPC_MPC512x)
+static inline void buffer_swap32(u32 *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < ((len + 3) / 4); i++) {
+		st_le32(buf, *buf);
+		buf++;
+	}
+}
+
+static void mxcmci_fixup_buffers(struct mmc_data *data)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(data->sg, sg, data->sg_len, i)
+		buffer_swap32(sg_virt(sg), sg->length);
+}
+#else
+static inline void mxcmci_fixup_buffers(struct mmc_data *data) {}
+#endif
+
 static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 {
 	unsigned int nob = data->blocks;
@@ -336,6 +359,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	} else {
 		host->dma_dir = DMA_TO_DEVICE;
 		slave_dirn = DMA_MEM_TO_DEV;
+
+		mxcmci_fixup_buffers(data);
 	}
 
 	nents = dma_map_sg(host->dma->device->dev, data->sg,
@@ -461,9 +486,11 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 	struct mmc_data *data = host->data;
 	int data_error;
 
-	if (mxcmci_use_dma(host))
+	if (mxcmci_use_dma(host)) {
 		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
 				host->dma_dir);
+		mxcmci_fixup_buffers(data);
+	}
 
 	if (stat & STATUS_ERR_MASK) {
 		dev_dbg(mmc_dev(host->mmc), "request failed. status: 0x%08x\n",
@@ -1033,7 +1060,6 @@ static int mxcmci_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	/* MMC core transfer sizes tunable parameters */
-	mmc->max_segs = 64;
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
@@ -1052,6 +1078,11 @@ static int mxcmci_probe(struct platform_device *pdev)
 	} else {
 		host->devtype = pdev->id_entry->driver_data;
 	}
+
+	/* adjust max_segs after devtype detection */
+	if (!is_mpc512x_mmc(host))
+		mmc->max_segs = 64;
+
 	host->mmc = mmc;
 	host->pdata = pdata;
 	spin_lock_init(&host->lock);
-- 
1.7.5.4


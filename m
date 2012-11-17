From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND v2] MMC: SD/MMC Host Controller for Wondermedia WM8505/WM8650
Date: Sat, 17 Nov 2012 16:44:57 -0500
Message-ID: <87lidz9a5i.fsf@octavius.laptop.org>
References: <1351311644-5455-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59979 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097Ab2KQVpD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 16:45:03 -0500
In-Reply-To: <1351311644-5455-1-git-send-email-linux@prisktech.co.nz> (Tony
	Prisk's message of "Sat, 27 Oct 2012 17:20:44 +1300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-mmc@vger.kernel.org

Hi Tony,

On Sat, Oct 27 2012, Tony Prisk wrote:
> This patch adds support for the SD/MMC host controller found
> on Wondermedia 8xxx series SoCs, currently supported under
> arm/arch-vt8500.
>
> A binding document is also included, based on mmc.txt with
> additional properties.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> This is a resend of the arch-vt8500 sd/mmc host controller patch for review.
>
> v2: Changes made as per review by Girish K S

Sorry for the delay.  This looks fine, just a few comments:

>  .../devicetree/bindings/mmc/vt8500-sdmmc.txt       |   24 +
>  drivers/mmc/host/Kconfig                           |   12 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/wmt-sdmmc.c                       | 1022 ++++++++++++++++++++
>  4 files changed, 1059 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
>  create mode 100644 drivers/mmc/host/wmt-sdmmc.c

Would you like to add a MAINTAINERS entry, too?

> diff --git a/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt b/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
> new file mode 100644
> index 0000000..69a817e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
> @@ -0,0 +1,24 @@
> +* Wondermedia WM8505/WM8650 SD/MMC Host Controller
> +
> +Required properties:
> +- compatible: Should be "wm,wm8505-sdhc".
> +- reg: Memory for sdhc controller.
> +- interrupts: Two interrupts are required - regular irq and dma irq.
> +- clocks: pHandle to clock for controller.
> +- bus-width: <1>,<4> or <8> data lines connected
> +
> +Optional properties:
> +- sdon-inverted: SD_ON bit is inverted on the controller
> +- cd-inverted: CD bit is inverted on the controller
> +
> +Examples:
> +
> +sdhc@d800a000 {
> +	compatible = "wm,wm8505-sdhc";
> +	reg = <0xd800a000 0x1000>;
> +	interrupts = <20 21>;
> +	clocks = <&sdhc>;
> +	bus-width = <4>;
> +	sdon-inverted;
> +};

It's not necessary to mention properties that are already covered by
mmc.txt outside of the examples section.  I think you can just say:

* Wondermedia WM8505/WM8650 SD/MMC Host Controller

This file documents differences between the core properties described
by mmc.txt and the properties used by the wmt-sdmmc driver.

Required properties:
- compatible: Should be "wm,wm8505-sdhc".
- interrupts: Two interrupts are required - regular irq and dma irq.

Optional properties:
- sdon-inverted: SD_ON bit is inverted on the controller

[..]
> +	if (status != DMA_CCR_EVT_SUCCESS) {
> +		pr_err("%s: DMA Error: Status = %d\n", __func__, status);

If it's possible to use more than one controller on the same system,
these pr_err()s (and the other uses of pr_*) would be better as
dev_err()s so that multiple controllers can be distinguished.

Finally, here's a trivial style patch to align better with the rest
of MMC, please apply it before you resend if you agree.  Thanks!

- Chris.


diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index b6d7148..5404dc1 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -216,21 +216,21 @@ static void wmt_set_sd_power(struct wmt_mci_priv *priv, int enable)
 		if (priv->power_inverted) {
 			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 			writeb(reg_tmp | BM_SD_OFF,
-				priv->sdmmc_base + SDMMC_BUSMODE);
+			       priv->sdmmc_base + SDMMC_BUSMODE);
 		} else {
 			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 			writeb(reg_tmp & (~BM_SD_OFF),
-				priv->sdmmc_base + SDMMC_BUSMODE);
+			       priv->sdmmc_base + SDMMC_BUSMODE);
 		}
 	} else {
 		if (priv->power_inverted) {
 			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 			writeb(reg_tmp & (~BM_SD_OFF),
-				priv->sdmmc_base + SDMMC_BUSMODE);
+			       priv->sdmmc_base + SDMMC_BUSMODE);
 		} else {
 			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 			writeb(reg_tmp | BM_SD_OFF,
-				priv->sdmmc_base + SDMMC_BUSMODE);
+			       priv->sdmmc_base + SDMMC_BUSMODE);
 		}
 	}
 }
@@ -251,7 +251,7 @@ static void wmt_mci_read_response(struct mmc_host *mmc)
 				tmp_resp = readb(priv->sdmmc_base + SDMMC_RSP);
 			else
 				tmp_resp = readb(priv->sdmmc_base + SDMMC_RSP +
-					(idx1*4) + idx2 + 1);
+						 (idx1*4) + idx2 + 1);
 			response |= (tmp_resp << (idx2 * 8));
 		}
 		priv->cmd->resp[idx1] = cpu_to_be32(response);
@@ -267,7 +267,7 @@ static void wmt_mci_start_command(struct wmt_mci_priv *priv)
 }
 
 static int wmt_mci_send_command(struct mmc_host *mmc, u8 command, u8 cmdtype,
-		u32 arg, u8 rsptype)
+				u32 arg,  u8 rsptype)
 {
 	struct wmt_mci_priv *priv;
 	u32 reg_tmp;
@@ -294,8 +294,8 @@ static int wmt_mci_send_command(struct mmc_host *mmc, u8 command, u8 cmdtype,
 
 	/* set command type */
 	reg_tmp = readb(priv->sdmmc_base + SDMMC_CTLR);
-	writeb((reg_tmp & 0x0F) | (cmdtype << 4), priv->sdmmc_base +
-		SDMMC_CTLR);
+	writeb((reg_tmp & 0x0F) | (cmdtype << 4),
+	       priv->sdmmc_base + SDMMC_CTLR);
 
 	return 0;
 }
@@ -316,10 +316,10 @@ static void wmt_complete_data_request(struct wmt_mci_priv *priv)
 	/* unmap the DMA pages used for write data */
 	if (req->data->flags & MMC_DATA_WRITE)
 		dma_unmap_sg(mmc_dev(priv->mmc), req->data->sg,
-			req->data->sg_len, DMA_TO_DEVICE);
+			     req->data->sg_len, DMA_TO_DEVICE);
 	else
 		dma_unmap_sg(mmc_dev(priv->mmc), req->data->sg,
-			req->data->sg_len, DMA_FROM_DEVICE);
+			     req->data->sg_len, DMA_FROM_DEVICE);
 
 	/* Check if the DMA ISR returned a data error */
 	if ((req->cmd->error) || (req->data->error))
@@ -339,7 +339,7 @@ static void wmt_complete_data_request(struct wmt_mci_priv *priv)
 			init_completion(priv->comp_cmd);
 			priv->cmd = req->data->stop;
 			wmt_mci_send_command(priv->mmc, req->data->stop->opcode,
-						7, req->data->stop->arg, 9);
+					     7, req->data->stop->arg, 9);
 			wmt_mci_start_command(priv);
 		}
 	}
@@ -413,17 +413,17 @@ static irqreturn_t wmt_mci_regular_isr(int irq_num, void *data)
 		return IRQ_HANDLED;
 	}
 
-	if ((!priv->req->data) || ((priv->req->data->stop) &&
-					(priv->cmd == priv->req->data->stop))) {
+	if (!priv->req->data ||
+	    (priv->req->data->stop && (priv->cmd == priv->req->data->stop))) {
 		/* handle non-data & stop_transmission requests */
 		if (status1 & STS1_CMDRSP_DONE) {
 			priv->cmd->error = 0;
 			cmd_done = 1;
-		} else
-		if ((status1 & STS1_RSP_TIMEOUT) ||
-					(status1 & STS1_DATA_TIMEOUT)) {
-			priv->cmd->error = -ETIMEDOUT;
-			cmd_done = 1;
+		}
+		else if ((status1 & STS1_RSP_TIMEOUT) ||
+			 (status1 & STS1_DATA_TIMEOUT)) {
+				priv->cmd->error = -ETIMEDOUT;
+				cmd_done = 1;
 		}
 		if (cmd_done) {
 			priv->comp_cmd = NULL;
@@ -445,7 +445,7 @@ static irqreturn_t wmt_mci_regular_isr(int irq_num, void *data)
 		}
 
 		if ((status1 & STS1_RSP_TIMEOUT) ||
-				(status1 & STS1_DATA_TIMEOUT)) {
+		    (status1 & STS1_DATA_TIMEOUT)) {
 			if (priv->cmd)
 				priv->cmd->error = -ETIMEDOUT;
 			if (priv->comp_cmd)
@@ -496,9 +496,9 @@ static void wmt_reset_hardware(struct mmc_host *mmc)
 
 	/* setup interrupts */
 	writeb(INT0_CD_INT_EN | INT0_DI_INT_EN, priv->sdmmc_base +
-		SDMMC_INTMASK0);
+	       SDMMC_INTMASK0);
 	writeb(INT1_DATA_TOUT_INT_EN | INT1_CMD_RES_TRAN_DONE_INT_EN |
-		INT1_CMD_RES_TOUT_INT_EN, priv->sdmmc_base + SDMMC_INTMASK1);
+	       INT1_CMD_RES_TOUT_INT_EN, priv->sdmmc_base + SDMMC_INTMASK1);
 
 	/* set the DMA timeout */
 	writew(8191, priv->sdmmc_base + SDMMC_DMATIMEOUT);
@@ -553,11 +553,11 @@ static void wmt_dma_config(struct mmc_host *mmc, u32 descaddr, u8 dir)
 	if (dir == PDMA_WRITE) {
 		reg_tmp = readl(priv->sdmmc_base + SDDMA_CCR);
 		writel(reg_tmp & DMA_CCR_IF_TO_PERIPHERAL, priv->sdmmc_base +
-				SDDMA_CCR);
+		       SDDMA_CCR);
 	} else {
 		reg_tmp = readl(priv->sdmmc_base + SDDMA_CCR);
 		writel(reg_tmp | DMA_CCR_PERIPHERAL_TO_IF, priv->sdmmc_base +
-				SDDMA_CCR);
+		       SDDMA_CCR);
 	}
 }
 
@@ -622,7 +622,7 @@ static void wmt_mci_request(struct mmc_host *mmc, struct mmc_request *req)
 		/* set controller data length */
 		reg_tmp = readw(priv->sdmmc_base + SDMMC_BLKLEN);
 		writew((reg_tmp & 0xF800) | (req->data->blksz - 1),
-			priv->sdmmc_base + SDMMC_BLKLEN);
+		       priv->sdmmc_base + SDMMC_BLKLEN);
 
 		/* set controller block count */
 		writew(req->data->blocks, priv->sdmmc_base + SDMMC_BLKCNT);
@@ -631,13 +631,13 @@ static void wmt_mci_request(struct mmc_host *mmc, struct mmc_request *req)
 
 		if (req->data->flags & MMC_DATA_WRITE) {
 			sg_cnt = dma_map_sg(mmc_dev(mmc), req->data->sg,
-					req->data->sg_len, DMA_TO_DEVICE);
+					    req->data->sg_len, DMA_TO_DEVICE);
 			cmdtype = 1;
 			if (req->data->blocks > 1)
 				cmdtype = 3;
 		} else {
 			sg_cnt = dma_map_sg(mmc_dev(mmc), req->data->sg,
-					req->data->sg_len, DMA_FROM_DEVICE);
+					    req->data->sg_len, DMA_FROM_DEVICE);
 			cmdtype = 2;
 			if (req->data->blocks > 1)
 				cmdtype = 4;
@@ -650,8 +650,8 @@ static void wmt_mci_request(struct mmc_host *mmc, struct mmc_request *req)
 			offset = 0;
 			while (offset < sg_dma_len(sg)) {
 				wmt_dma_init_descriptor(desc, req->data->blksz,
-					sg_dma_address(sg)+offset, dma_address,
-					0);
+						sg_dma_address(sg)+offset,
+						dma_address, 0);
 				desc++;
 				desc_cnt++;
 				offset += req->data->blksz;
@@ -665,10 +665,10 @@ static void wmt_mci_request(struct mmc_host *mmc, struct mmc_request *req)
 
 		if (req->data->flags & MMC_DATA_WRITE)
 			wmt_dma_config(mmc, priv->dma_desc_device_addr,
-					PDMA_WRITE);
+				       PDMA_WRITE);
 		else
 			wmt_dma_config(mmc, priv->dma_desc_device_addr,
-					PDMA_READ);
+				       PDMA_READ);
 
 		wmt_mci_send_command(mmc, command, cmdtype, arg, rsptype);
 
@@ -706,7 +706,7 @@ static void wmt_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_BUS_WIDTH_4:
 		reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 		writeb(reg_tmp | BM_FOURBIT_MODE, priv->sdmmc_base +
-			SDMMC_BUSMODE);
+		       SDMMC_BUSMODE);
 
 		reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
 		writeb(reg_tmp & 0xFB, priv->sdmmc_base + SDMMC_EXTCTRL);
@@ -714,7 +714,7 @@ static void wmt_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_BUS_WIDTH_1:
 		reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 		writeb(reg_tmp & BM_ONEBIT_MASK, priv->sdmmc_base +
-			SDMMC_BUSMODE);
+		       SDMMC_BUSMODE);
 
 		reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
 		writeb(reg_tmp & 0xFB, priv->sdmmc_base + SDMMC_EXTCTRL);
@@ -750,7 +750,7 @@ static struct wmt_mci_caps wm8505_caps = {
 	.f_max = 50000000,
 	.ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps = MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED |
-						MMC_CAP_SD_HIGHSPEED,
+		MMC_CAP_SD_HIGHSPEED,
 	.max_seg_size = 65024,
 	.max_segs = 128,
 	.max_blk_size = 2048,
@@ -767,7 +767,7 @@ static int __devinit wmt_mci_probe(struct platform_device *pdev)
 	struct wmt_mci_priv *priv;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
-				of_match_device(wmt_mci_dt_ids, &pdev->dev);
+		of_match_device(wmt_mci_dt_ids, &pdev->dev);
 	const struct wmt_mci_caps *wmt_caps = of_id->data;
 	int ret;
 	int regular_irq, dma_irq;
@@ -779,7 +779,7 @@ static int __devinit wmt_mci_probe(struct platform_device *pdev)
 
 	if (!np) {
 		pr_err("%s: Missing SDMMC description in devicetree\n",
-								__func__);
+		       __func__);
 		return -EFAULT;
 	}
 
@@ -847,7 +847,9 @@ static int __devinit wmt_mci_probe(struct platform_device *pdev)
 
 	/* alloc some DMA buffers for descriptors/transfers */
 	priv->dma_desc_buffer = dma_alloc_coherent(&pdev->dev,
-		mmc->max_blk_count * 16, &priv->dma_desc_device_addr, 208);
+						   mmc->max_blk_count * 16,
+						   &priv->dma_desc_device_addr,
+						   208);
 	if (!priv->dma_desc_buffer) {
 		pr_err("%s: DMA alloc fail\n", __func__);
 		ret = -EPERM;
@@ -905,7 +907,7 @@ static int __devexit wmt_mci_remove(struct platform_device *pdev)
 
 	/* release the dma buffers */
 	dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
-			priv->dma_desc_buffer, priv->dma_desc_device_addr);
+			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
 
 	mmc_remove_host(mmc);
 
@@ -947,7 +949,7 @@ static int wmt_mci_suspend(struct device *dev)
 	if (!ret) {
 		reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 		writeb(reg_tmp | BM_SOFT_RESET, priv->sdmmc_base +
-			SDMMC_BUSMODE);
+		       SDMMC_BUSMODE);
 
 		reg_tmp = readw(priv->sdmmc_base + SDMMC_BLKLEN);
 		writew(reg_tmp & 0x5FFF, priv->sdmmc_base + SDMMC_BLKLEN);
@@ -974,15 +976,15 @@ static int wmt_mci_resume(struct device *dev)
 
 		reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
 		writeb(reg_tmp | BM_SOFT_RESET, priv->sdmmc_base +
-			SDMMC_BUSMODE);
+		       SDMMC_BUSMODE);
 
 		reg_tmp = readw(priv->sdmmc_base + SDMMC_BLKLEN);
 		writew(reg_tmp | (BLKL_GPI_CD | BLKL_INT_ENABLE),
-			priv->sdmmc_base + SDMMC_BLKLEN);
+		       priv->sdmmc_base + SDMMC_BLKLEN);
 
 		reg_tmp = readb(priv->sdmmc_base + SDMMC_INTMASK0);
 		writeb(reg_tmp | INT0_DI_INT_EN, priv->sdmmc_base +
-			SDMMC_INTMASK0);
+		       SDMMC_INTMASK0);
 
 		ret = mmc_resume_host(mmc);
 	}


-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 09/13] mmc: mediatek: add stop_clk fix and enhance_rx
 support
Date: Mon, 9 Oct 2017 17:00:53 +0200
Message-ID: <f3bea03b-9fc3-ba60-da2d-63438df96e27@gmail.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-10-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507548926-9555-10-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On 10/09/2017 01:35 PM, Chaotian Jing wrote:
> mt2712 supports stop_clk fix and enhance_rx, which can improve
> host stability.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/mmc/host/mtk-sd.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 555824d..5d99e05 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -67,6 +67,7 @@
>   #define SDC_RESP2        0x48
>   #define SDC_RESP3        0x4c
>   #define SDC_BLK_NUM      0x50
> +#define SDC_ADV_CFG0     0x64
>   #define EMMC_IOCON       0x7c
>   #define SDC_ACMD_RESP    0x80
>   #define MSDC_DMA_SA      0x90
> @@ -80,6 +81,7 @@
>   #define PAD_DS_TUNE      0x188
>   #define PAD_CMD_TUNE     0x18c
>   #define EMMC50_CFG0      0x208
> +#define SDC_FIFO_CFG     0x228
>   
>   /*--------------------------------------------------------------------------*/
>   /* Register Mask                                                            */
> @@ -188,6 +190,9 @@
>   #define SDC_STS_CMDBUSY         (0x1 << 1)	/* RW */
>   #define SDC_STS_SWR_COMPL       (0x1 << 31)	/* RW */
>   
> +/* SDC_ADV_CFG0 mask */
> +#define SDC_RX_ENHANCE_EN	(0x1 << 20)	/* RW */
> +
>   /* MSDC_DMA_CTRL mask */
>   #define MSDC_DMA_CTRL_START     (0x1 << 0)	/* W */
>   #define MSDC_DMA_CTRL_STOP      (0x1 << 1)	/* W */
> @@ -217,6 +222,8 @@
>   #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
>   #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
>   
> +#define MSDC_PATCH_BIT1_STOP_DLY  (0xf << 8)    /* RW */
> +
>   #define MSDC_PATCH_BIT2_CFGRESP   (0x1 << 15)   /* RW */
>   #define MSDC_PATCH_BIT2_CFGCRCSTS (0x1 << 28)   /* RW */
>   #define MSDC_PB2_RESPWAIT         (0x3 << 2)    /* RW */
> @@ -242,6 +249,9 @@
>   #define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
>   #define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)   /* RW */
>   
> +#define SDC_FIFO_CFG_WRVALIDSEL   (0x1 << 24)  /* RW */
> +#define SDC_FIFO_CFG_RDVALIDSEL   (0x1 << 25)  /* RW */
> +
>   #define REQ_CMD_EIO  (0x1 << 0)
>   #define REQ_CMD_TMO  (0x1 << 1)
>   #define REQ_DAT_ERR  (0x1 << 2)
> @@ -308,6 +318,7 @@ struct msdc_save_para {
>   	u32 pad_ds_tune;
>   	u32 pad_cmd_tune;
>   	u32 emmc50_cfg0;
> +	u32 sdc_fifo_cfg;
>   };
>   
>   struct mtk_mmc_compatible {
> @@ -316,6 +327,8 @@ struct mtk_mmc_compatible {
>   	bool async_fifo;
>   	bool data_tune;
>   	bool busy_check;
> +	bool stop_clk_fix;
> +	bool enhance_rx;
>   };
>   
>   struct msdc_tune_para {
> @@ -381,6 +394,8 @@ struct msdc_host {
>   	.async_fifo = false,
>   	.data_tune = false,
>   	.busy_check = false,
> +	.stop_clk_fix = false,
> +	.enhance_rx = false,
>   };
>   
>   static const struct mtk_mmc_compatible mt8173_compat = {
> @@ -389,6 +404,8 @@ struct msdc_host {
>   	.async_fifo = false,
>   	.data_tune = false,
>   	.busy_check = false,
> +	.stop_clk_fix = false,
> +	.enhance_rx = false,
>   };
>   

If you add a flag for hs400_tune then mt8173_compat and mt8135_compat will be 
actually different and therefore it will make sense that they exist both in the 
driver code.

Regards,
Matthias

>   static const struct mtk_mmc_compatible mt2701_compat = {
> @@ -397,6 +414,8 @@ struct msdc_host {
>   	.async_fifo = true,
>   	.data_tune = true,
>   	.busy_check = false,
> +	.stop_clk_fix = false,
> +	.enhance_rx = false,
>   };
>   
>   static const struct mtk_mmc_compatible mt2712_compat = {
> @@ -405,6 +424,8 @@ struct msdc_host {
>   	.async_fifo = true,
>   	.data_tune = true,
>   	.busy_check = true,
> +	.stop_clk_fix = true,
> +	.enhance_rx = true,
>   };
>   
>   static const struct of_device_id msdc_of_ids[] = {
> @@ -1281,15 +1302,31 @@ static void msdc_init_hw(struct msdc_host *host)
>   	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
>   	writel(0xffff4089, host->base + MSDC_PATCH_BIT1);
>   	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
> +
> +	if (host->dev_comp->stop_clk_fix) {
> +		sdr_set_field(host->base + MSDC_PATCH_BIT1,
> +			      MSDC_PATCH_BIT1_STOP_DLY, 3);
> +		sdr_clr_bits(host->base + SDC_FIFO_CFG,
> +			     SDC_FIFO_CFG_WRVALIDSEL);
> +		sdr_clr_bits(host->base + SDC_FIFO_CFG,
> +			     SDC_FIFO_CFG_RDVALIDSEL);
> +	}
> +
>   	if (host->dev_comp->busy_check)
>   		sdr_clr_bits(host->base + MSDC_PATCH_BIT1, (1 << 7));
> +
>   	if (host->dev_comp->async_fifo) {
>   		sdr_set_field(host->base + MSDC_PATCH_BIT2,
>   			      MSDC_PB2_RESPWAIT, 3);
> -		sdr_set_field(host->base + MSDC_PATCH_BIT2,
> -			      MSDC_PB2_RESPSTSENSEL, 2);
> -		sdr_set_field(host->base + MSDC_PATCH_BIT2,
> -			      MSDC_PB2_CRCSTSENSEL, 2);
> +		if (host->dev_comp->enhance_rx) {
> +			sdr_set_bits(host->base + SDC_ADV_CFG0,
> +				     SDC_RX_ENHANCE_EN);
> +		} else {
> +			sdr_set_field(host->base + MSDC_PATCH_BIT2,
> +				      MSDC_PB2_RESPSTSENSEL, 2);
> +			sdr_set_field(host->base + MSDC_PATCH_BIT2,
> +				      MSDC_PB2_CRCSTSENSEL, 2);
> +		}
>   		/* use async fifo, then no need tune internal delay */
>   		sdr_clr_bits(host->base + MSDC_PATCH_BIT2,
>   			     MSDC_PATCH_BIT2_CFGRESP);
> @@ -1946,6 +1983,7 @@ static void msdc_save_reg(struct msdc_host *host)
>   	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
>   	host->save_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
>   	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
> +	host->save_para.sdc_fifo_cfg = readl(host->base + SDC_FIFO_CFG);
>   }
>   
>   static void msdc_restore_reg(struct msdc_host *host)
> @@ -1964,6 +2002,7 @@ static void msdc_restore_reg(struct msdc_host *host)
>   	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
>   	writel(host->save_para.pad_cmd_tune, host->base + PAD_CMD_TUNE);
>   	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
> +	writel(host->save_para.sdc_fifo_cfg, host->base + SDC_FIFO_CFG);
>   }
>   
>   static int msdc_runtime_suspend(struct device *dev)
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

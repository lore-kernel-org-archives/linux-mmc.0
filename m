From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 5/6] mmc: mediatek: add MT8183 MMC driver support
Date: Fri, 19 Oct 2018 11:04:04 +0200
Message-ID: <f633e2b0-39f3-288d-c5d5-2d4b27d8e824@gmail.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
 <1539415250-32337-6-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539415250-32337-6-git-send-email-chaotian.jing@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 13/10/2018 09:20, Chaotian Jing wrote:
> MT8183 puts the tune register at top layer, so need add new code
> to support it.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 283 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 233 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 09d7e44..5b26f2f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -87,6 +87,13 @@
>  #define SDC_FIFO_CFG     0x228
>  
>  /*--------------------------------------------------------------------------*/
> +/* Top Pad Register Offset                                                  */
> +/*--------------------------------------------------------------------------*/
> +#define EMMC_TOP_CONTROL	0x00
> +#define EMMC_TOP_CMD		0x04
> +#define EMMC50_PAD_DS_TUNE	0x0c
> +
> +/*--------------------------------------------------------------------------*/
>  /* Register Mask                                                            */
>  /*--------------------------------------------------------------------------*/
>  
> @@ -261,6 +268,23 @@
>  #define SDC_FIFO_CFG_WRVALIDSEL   (0x1 << 24)  /* RW */
>  #define SDC_FIFO_CFG_RDVALIDSEL   (0x1 << 25)  /* RW */
>  
> +/* EMMC_TOP_CONTROL mask */
> +#define PAD_RXDLY_SEL           (0x1 << 0)      /* RW */
> +#define DELAY_EN                (0x1 << 1)      /* RW */
> +#define PAD_DAT_RD_RXDLY2       (0x1f << 2)     /* RW */
> +#define PAD_DAT_RD_RXDLY        (0x1f << 7)     /* RW */
> +#define PAD_DAT_RD_RXDLY2_SEL   (0x1 << 12)     /* RW */
> +#define PAD_DAT_RD_RXDLY_SEL    (0x1 << 13)     /* RW */
> +#define DATA_K_VALUE_SEL        (0x1 << 14)     /* RW */
> +#define SDC_RX_ENH_EN           (0x1 << 15)     /* TW */
> +
> +/* EMMC_TOP_CMD mask */
> +#define PAD_CMD_RXDLY2          (0x1f << 0)     /* RW */
> +#define PAD_CMD_RXDLY           (0x1f << 5)     /* RW */
> +#define PAD_CMD_RD_RXDLY2_SEL   (0x1 << 10)     /* RW */
> +#define PAD_CMD_RD_RXDLY_SEL    (0x1 << 11)     /* RW */
> +#define PAD_CMD_TX_DLY          (0x1f << 12)    /* RW */
> +
>  #define REQ_CMD_EIO  (0x1 << 0)
>  #define REQ_CMD_TMO  (0x1 << 1)
>  #define REQ_DAT_ERR  (0x1 << 2)
> @@ -333,6 +357,9 @@ struct msdc_save_para {
>  	u32 emmc50_cfg0;
>  	u32 emmc50_cfg3;
>  	u32 sdc_fifo_cfg;
> +	u32 emmc_top_control;
> +	u32 emmc_top_cmd;
> +	u32 emmc50_pad_ds_tune;
>  };
>  
>  struct mtk_mmc_compatible {
> @@ -351,6 +378,8 @@ struct msdc_tune_para {
>  	u32 iocon;
>  	u32 pad_tune;
>  	u32 pad_cmd_tune;
> +	u32 emmc_top_control;
> +	u32 emmc_top_cmd;
>  };
>  
>  struct msdc_delay_phase {
> @@ -372,6 +401,7 @@ struct msdc_host {
>  	int error;
>  
>  	void __iomem *base;		/* host base address */
> +	void __iomem *top_base;		/* host top register base address */

Where do you assign a value to top_base?
I'm not familiar with the driver, but couldn't we reuse base and a flag for
example in mtk_mmc_compatible to check which tune register we need to use?

Regards,
Matthias


>  
>  	struct msdc_dma dma;	/* dma channel */
>  	u64 dma_mask;
> @@ -429,6 +459,18 @@ struct msdc_host {
>  	.support_64g = false,
>  };
>  
> +static const struct mtk_mmc_compatible mt8183_compat = {
> +	.clk_div_bits = 12,
> +	.hs400_tune = false,
> +	.pad_tune_reg = MSDC_PAD_TUNE0,
> +	.async_fifo = true,
> +	.data_tune = true,
> +	.busy_check = true,
> +	.stop_clk_fix = true,
> +	.enhance_rx = true,
> +	.support_64g = true,
> +};
> +
>  static const struct mtk_mmc_compatible mt2701_compat = {
>  	.clk_div_bits = 12,
>  	.hs400_tune = false,
> @@ -468,6 +510,7 @@ struct msdc_host {
>  static const struct of_device_id msdc_of_ids[] = {
>  	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>  	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
>  	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
>  	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
>  	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
> @@ -777,12 +820,28 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>  	 */
>  	if (host->mmc->actual_clock <= 52000000) {
>  		writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
> -		writel(host->def_tune_para.pad_tune, host->base + tune_reg);
> +		if (host->top_base) {
> +			writel(host->def_tune_para.emmc_top_control,
> +			       host->top_base + EMMC_TOP_CONTROL);
> +			writel(host->def_tune_para.emmc_top_cmd,
> +			       host->top_base + EMMC_TOP_CMD);
> +		} else {
> +			writel(host->def_tune_para.pad_tune,
> +			       host->base + tune_reg);
> +		}
>  	} else {
>  		writel(host->saved_tune_para.iocon, host->base + MSDC_IOCON);
> -		writel(host->saved_tune_para.pad_tune, host->base + tune_reg);
>  		writel(host->saved_tune_para.pad_cmd_tune,
>  		       host->base + PAD_CMD_TUNE);
> +		if (host->top_base) {
> +			writel(host->saved_tune_para.emmc_top_control,
> +			       host->top_base + EMMC_TOP_CONTROL);
> +			writel(host->saved_tune_para.emmc_top_cmd,
> +			       host->top_base + EMMC_TOP_CMD);
> +		} else {
> +			writel(host->saved_tune_para.pad_tune,
> +			       host->base + tune_reg);
> +		}
>  	}
>  
>  	if (timing == MMC_TIMING_MMC_HS400 &&
> @@ -1355,7 +1414,12 @@ static void msdc_init_hw(struct msdc_host *host)
>  	val = readl(host->base + MSDC_INT);
>  	writel(val, host->base + MSDC_INT);
>  
> -	writel(0, host->base + tune_reg);
> +	if (host->top_base) {
> +		writel(0, host->top_base + EMMC_TOP_CONTROL);
> +		writel(0, host->top_base + EMMC_TOP_CMD);
> +	} else {
> +		writel(0, host->base + tune_reg);
> +	}
>  	writel(0, host->base + MSDC_IOCON);
>  	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
>  	writel(0x403c0046, host->base + MSDC_PATCH_BIT);
> @@ -1379,8 +1443,12 @@ static void msdc_init_hw(struct msdc_host *host)
>  		sdr_set_field(host->base + MSDC_PATCH_BIT2,
>  			      MSDC_PB2_RESPWAIT, 3);
>  		if (host->dev_comp->enhance_rx) {
> -			sdr_set_bits(host->base + SDC_ADV_CFG0,
> -				     SDC_RX_ENHANCE_EN);
> +			if (host->top_base)
> +				sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
> +					     SDC_RX_ENH_EN);
> +			else
> +				sdr_set_bits(host->base + SDC_ADV_CFG0,
> +					     SDC_RX_ENHANCE_EN);
>  		} else {
>  			sdr_set_field(host->base + MSDC_PATCH_BIT2,
>  				      MSDC_PB2_RESPSTSENSEL, 2);
> @@ -1398,11 +1466,26 @@ static void msdc_init_hw(struct msdc_host *host)
>  		sdr_set_bits(host->base + MSDC_PATCH_BIT2,
>  			     MSDC_PB2_SUPPORT_64G);
>  	if (host->dev_comp->data_tune) {
> -		sdr_set_bits(host->base + tune_reg,
> -			     MSDC_PAD_TUNE_RD_SEL | MSDC_PAD_TUNE_CMD_SEL);
> +		if (host->top_base) {
> +			sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
> +				     PAD_DAT_RD_RXDLY_SEL);
> +			sdr_clr_bits(host->top_base + EMMC_TOP_CONTROL,
> +				     DATA_K_VALUE_SEL);
> +			sdr_set_bits(host->top_base + EMMC_TOP_CMD,
> +				     PAD_CMD_RD_RXDLY_SEL);
> +		} else {
> +			sdr_set_bits(host->base + tune_reg,
> +				     MSDC_PAD_TUNE_RD_SEL |
> +				     MSDC_PAD_TUNE_CMD_SEL);
> +		}
>  	} else {
>  		/* choose clock tune */
> -		sdr_set_bits(host->base + tune_reg, MSDC_PAD_TUNE_RXDLYSEL);
> +		if (host->top_base)
> +			sdr_set_bits(host->top_base + EMMC_TOP_CONTROL,
> +				     PAD_RXDLY_SEL);
> +		else
> +			sdr_set_bits(host->base + tune_reg,
> +				     MSDC_PAD_TUNE_RXDLYSEL);
>  	}
>  
>  	/* Configure to enable SDIO mode.
> @@ -1417,9 +1500,20 @@ static void msdc_init_hw(struct msdc_host *host)
>  	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
>  
>  	host->def_tune_para.iocon = readl(host->base + MSDC_IOCON);
> -	host->def_tune_para.pad_tune = readl(host->base + tune_reg);
>  	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
> -	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
> +	if (host->top_base) {
> +		host->def_tune_para.emmc_top_control =
> +			readl(host->top_base + EMMC_TOP_CONTROL);
> +		host->def_tune_para.emmc_top_cmd =
> +			readl(host->top_base + EMMC_TOP_CMD);
> +		host->saved_tune_para.emmc_top_control =
> +			readl(host->top_base + EMMC_TOP_CONTROL);
> +		host->saved_tune_para.emmc_top_cmd =
> +			readl(host->top_base + EMMC_TOP_CMD);
> +	} else {
> +		host->def_tune_para.pad_tune = readl(host->base + tune_reg);
> +		host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
> +	}
>  	dev_dbg(host->dev, "init hardware done!");
>  }
>  
> @@ -1587,8 +1681,12 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>  
>  	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
>  		/*
>  		 * Using the same parameters, it may sometimes pass the test,
>  		 * but sometimes it may fail. To make sure the parameters are
> @@ -1612,8 +1710,12 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>  
>  	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  	for (i = 0; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
>  		/*
>  		 * Using the same parameters, it may sometimes pass the test,
>  		 * but sometimes it may fail. To make sure the parameters are
> @@ -1637,13 +1739,23 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
>  		final_maxlen = final_fall_delay.maxlen;
>  	if (final_maxlen == final_rise_delay.maxlen) {
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_rise_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
> +				      final_rise_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY,
> +				      final_rise_delay.final_phase);
>  		final_delay = final_rise_delay.final_phase;
>  	} else {
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_fall_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->base + EMMC_TOP_CMD, PAD_CMD_RXDLY,
> +				      final_fall_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY,
> +				      final_fall_delay.final_phase);
>  		final_delay = final_fall_delay.final_phase;
>  	}
>  	if (host->dev_comp->async_fifo || host->hs200_cmd_int_delay)
> @@ -1728,8 +1840,12 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>  	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
>  	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			rise_delay |= (1 << i);
> @@ -1743,8 +1859,12 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>  	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  	sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
>  	for (i = 0; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			fall_delay |= (1 << i);
> @@ -1756,16 +1876,26 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
>  	if (final_maxlen == final_rise_delay.maxlen) {
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_rise_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY,
> +				      final_rise_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY,
> +				      final_rise_delay.final_phase);
>  		final_delay = final_rise_delay.final_phase;
>  	} else {
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_fall_delay.final_phase);
> +		if (host->top_base)
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY,
> +				      final_fall_delay.final_phase);
> +		else
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY,
> +				      final_fall_delay.final_phase);
>  		final_delay = final_fall_delay.final_phase;
>  	}
>  
> @@ -1793,10 +1923,17 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>  	sdr_clr_bits(host->base + MSDC_IOCON,
>  		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
>  	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base) {
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		} else {
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
> +		}
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			rise_delay |= (1 << i);
> @@ -1811,10 +1948,17 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>  	sdr_set_bits(host->base + MSDC_IOCON,
>  		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
>  	for (i = 0; i < PAD_DELAY_MAX; i++) {
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_CMDRDLY, i);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY, i);
> +		if (host->top_base) {
> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +				      PAD_CMD_RXDLY, i);
> +			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +				      PAD_DAT_RD_RXDLY, i);
> +		} else {
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_CMDRDLY, i);
> +			sdr_set_field(host->base + tune_reg,
> +				      MSDC_PAD_TUNE_DATRRDLY, i);
> +		}
>  		ret = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!ret)
>  			fall_delay |= (1 << i);
> @@ -1827,22 +1971,24 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
>  		sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  		sdr_clr_bits(host->base + MSDC_IOCON,
>  			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> -		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_rise_delay.final_phase);
> -		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_rise_delay.final_phase);
>  		final_delay = final_rise_delay.final_phase;
>  	} else {
>  		sdr_set_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
>  		sdr_set_bits(host->base + MSDC_IOCON,
>  			     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> +		final_delay = final_fall_delay.final_phase;
> +	}
> +
> +	if (host->top_base) {
> +		sdr_set_field(host->top_base + EMMC_TOP_CMD,
> +			      PAD_CMD_RXDLY, final_delay);
> +		sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +			      PAD_DAT_RD_RXDLY, final_delay);
> +	} else {
>  		sdr_set_field(host->base + tune_reg, MSDC_PAD_TUNE_CMDRDLY,
> -			      final_fall_delay.final_phase);
> +			      final_delay);
>  		sdr_set_field(host->base + tune_reg,
> -			      MSDC_PAD_TUNE_DATRRDLY,
> -			      final_fall_delay.final_phase);
> -		final_delay = final_fall_delay.final_phase;
> +			      MSDC_PAD_TUNE_DATRRDLY, final_delay);
>  	}
>  
>  	dev_dbg(host->dev, "Final pad delay: %x\n", final_delay);
> @@ -1860,8 +2006,12 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		if (host->hs400_mode) {
>  			sdr_clr_bits(host->base + MSDC_IOCON,
>  				     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
> -			sdr_set_field(host->base + tune_reg,
> -				      MSDC_PAD_TUNE_DATRRDLY, 0);
> +			if (host->top_base)
> +				sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> +					      PAD_DAT_RD_RXDLY, 0);
> +			else
> +				sdr_set_field(host->base + tune_reg,
> +					      MSDC_PAD_TUNE_DATRRDLY, 0);
>  		}
>  		goto tune_done;
>  	}
> @@ -1884,6 +2034,12 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	host->saved_tune_para.iocon = readl(host->base + MSDC_IOCON);
>  	host->saved_tune_para.pad_tune = readl(host->base + tune_reg);
>  	host->saved_tune_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
> +	if (host->top_base) {
> +		host->saved_tune_para.emmc_top_control = readl(host->top_base +
> +				EMMC_TOP_CONTROL);
> +		host->saved_tune_para.emmc_top_cmd = readl(host->top_base +
> +				EMMC_TOP_CMD);
> +	}
>  	return ret;
>  }
>  
> @@ -1892,7 +2048,11 @@ static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct msdc_host *host = mmc_priv(mmc);
>  	host->hs400_mode = true;
>  
> -	writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
> +	if (host->top_base)
> +		writel(host->hs400_ds_delay,
> +		       host->top_base + EMMC50_PAD_DS_TUNE);
> +	else
> +		writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
>  	/* hs400 mode must set it to 0 */
>  	sdr_clr_bits(host->base + MSDC_PATCH_BIT2, MSDC_PATCH_BIT2_CFGCRCSTS);
>  	/* to improve read performance, set outstanding to 2 */
> @@ -1975,6 +2135,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	host->top_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(host->top_base))
> +		host->top_base = NULL;
> +
>  	ret = mmc_regulator_get_supply(mmc);
>  	if (ret)
>  		goto host_free;
> @@ -2143,7 +2308,6 @@ static void msdc_save_reg(struct msdc_host *host)
>  	host->save_para.msdc_cfg = readl(host->base + MSDC_CFG);
>  	host->save_para.iocon = readl(host->base + MSDC_IOCON);
>  	host->save_para.sdc_cfg = readl(host->base + SDC_CFG);
> -	host->save_para.pad_tune = readl(host->base + tune_reg);
>  	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
>  	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
>  	host->save_para.patch_bit2 = readl(host->base + MSDC_PATCH_BIT2);
> @@ -2152,6 +2316,16 @@ static void msdc_save_reg(struct msdc_host *host)
>  	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
>  	host->save_para.emmc50_cfg3 = readl(host->base + EMMC50_CFG3);
>  	host->save_para.sdc_fifo_cfg = readl(host->base + SDC_FIFO_CFG);
> +	if (host->top_base) {
> +		host->save_para.emmc_top_control =
> +			readl(host->top_base + EMMC_TOP_CONTROL);
> +		host->save_para.emmc_top_cmd =
> +			readl(host->top_base + EMMC_TOP_CMD);
> +		host->save_para.emmc50_pad_ds_tune =
> +			readl(host->top_base + EMMC50_PAD_DS_TUNE);
> +	} else {
> +		host->save_para.pad_tune = readl(host->base + tune_reg);
> +	}
>  }
>  
>  static void msdc_restore_reg(struct msdc_host *host)
> @@ -2161,7 +2335,6 @@ static void msdc_restore_reg(struct msdc_host *host)
>  	writel(host->save_para.msdc_cfg, host->base + MSDC_CFG);
>  	writel(host->save_para.iocon, host->base + MSDC_IOCON);
>  	writel(host->save_para.sdc_cfg, host->base + SDC_CFG);
> -	writel(host->save_para.pad_tune, host->base + tune_reg);
>  	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
>  	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
>  	writel(host->save_para.patch_bit2, host->base + MSDC_PATCH_BIT2);
> @@ -2170,6 +2343,16 @@ static void msdc_restore_reg(struct msdc_host *host)
>  	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
>  	writel(host->save_para.emmc50_cfg3, host->base + EMMC50_CFG3);
>  	writel(host->save_para.sdc_fifo_cfg, host->base + SDC_FIFO_CFG);
> +	if (host->top_base) {
> +		writel(host->save_para.emmc_top_control,
> +		       host->top_base + EMMC_TOP_CONTROL);
> +		writel(host->save_para.emmc_top_cmd,
> +		       host->top_base + EMMC_TOP_CMD);
> +		writel(host->save_para.emmc50_pad_ds_tune,
> +		       host->top_base + EMMC50_PAD_DS_TUNE);
> +	} else {
> +		writel(host->save_para.pad_tune, host->base + tune_reg);
> +	}
>  }
>  
>  static int msdc_runtime_suspend(struct device *dev)
> 

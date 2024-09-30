Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39318870E;
	Mon, 30 Sep 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687635; cv=none; b=RSKeefTK5KFX294KO2IXE2OZSBaILuUn2IjsmQlRL2/+JsVEXa8fn86Plf5yDGpNRjL/JuPGFXf88NNOppTBO+KNEJkF9C/9iqg88kTPeh9yAvaFWpX5iozbAB3l3Xt60ahL7V2eFO60fEAroOaBb4Idcuv5MtK/TXyTv5vqjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687635; c=relaxed/simple;
	bh=ekXh5zJ922BUPQ2ysuU/fcRhDon1l4dt3zODYpF+oJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOtDbLXUxpttg1XvA8flsZvvxorgCGQ+lAQJIO35ZsTH7/QyK60cRMp6BcARsGjBfaxLF+DeN1pT5KMBBW6FupRj4LjyqsBoB+MycKCQA33QIFtGjGAn2cylBM0mOujMrwRxLVZ5tzpnbM3UFbKOImwoR/etgCgVDh6XB/Fsbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mxaFcp+4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mxaFcp+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727687631;
	bh=ekXh5zJ922BUPQ2ysuU/fcRhDon1l4dt3zODYpF+oJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mxaFcp+4AIKcC2zcMkACfq45GZrLQrDz+uJPnKgBGjB4X33urnh5nqy8qdjynC4l+
	 snR74I2WkiU8sXfExn81xtMXzRDhaLaRvn/mZJWKtgmBsCv2DtguqJDkOJvKT/sXuA
	 XlefYorryRIx3gwoHubM5agEzBAZwC1/mAYCrjKBx5+FF9kTBZYXD8KL/08/UhCMD6
	 TeWYNlLXrEy3LFVYEBVsvHGCqldPxrqDjh7RYod7651iNo5w24hyEEvLA1IMcKut39
	 51570TETY3WbEH7h3auJZHjpieZu/aNhpC9PnYo1rQ/i2NSIFFfsWRrUv2anMxpiM0
	 q07VsemLHfZ7w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5610A17E0F6A;
	Mon, 30 Sep 2024 11:13:51 +0200 (CEST)
Message-ID: <e969918b-3af4-4880-9dc6-fba868a9937a@collabora.com>
Date: Mon, 30 Sep 2024 11:13:50 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: mtk-sd: Add support for MT8196
To: Andy-ld Lu <andy-ld.lu@mediatek.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
 wenbin.mei@mediatek.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240929074558.2076-1-andy-ld.lu@mediatek.com>
 <20240929074558.2076-2-andy-ld.lu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240929074558.2076-2-andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/09/24 09:44, Andy-ld Lu ha scritto:
> Mediatek SoC MT8196 features a new design for tx/rx path. The new tx
> path incorporates register settings that are closely associated with
> bus timing. And the difference between new rx path and older versions
> is the usage of distinct register bits when setting the data sampling
> edge as part of the tuning process.
> 
> Besides, there are modified register settings for STOP_DLY_SEL and
> POP_EN_CNT, with two new fields added to the compatibility structure
> to reflect the modifications.
> 
> For the changes mentioned in relation to the MT8196, the new compatible
> string 'mediatek,mt8196-mmc' is introduced. This is to accommodate
> different settings and workflows specific to the MT8196.
> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
> ---
>   drivers/mmc/host/mtk-sd.c | 162 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 141 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 89018b6c97b9..4254b3012aeb 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -65,6 +65,7 @@
>   #define SDC_RESP3        0x4c
>   #define SDC_BLK_NUM      0x50
>   #define SDC_ADV_CFG0     0x64
> +#define MSDC_NEW_RX_CFG  0x68
>   #define EMMC_IOCON       0x7c
>   #define SDC_ACMD_RESP    0x80
>   #define DMA_SA_H4BIT     0x8c
> @@ -91,6 +92,7 @@
>   #define EMMC_TOP_CONTROL	0x00
>   #define EMMC_TOP_CMD		0x04
>   #define EMMC50_PAD_DS_TUNE	0x0c
> +#define LOOP_TEST_CONTROL	0x30
>   
>   /*--------------------------------------------------------------------------*/
>   /* Register Mask                                                            */
> @@ -202,9 +204,13 @@
>   #define SDC_STS_CMDBUSY         BIT(1)	/* RW */
>   #define SDC_STS_SWR_COMPL       BIT(31)	/* RW */
>   
> -#define SDC_DAT1_IRQ_TRIGGER	BIT(19)	/* RW */
>   /* SDC_ADV_CFG0 mask */
> +#define SDC_DAT1_IRQ_TRIGGER	BIT(19)	/* RW */
>   #define SDC_RX_ENHANCE_EN	BIT(20)	/* RW */
> +#define SDC_NEW_TX_EN		BIT(31)	/* RW */
> +
> +/* MSDC_NEW_RX_CFG mask */
> +#define MSDC_NEW_RX_PATH_SEL	BIT(0)	/* RW */
>   
>   /* DMA_SA_H4BIT mask */
>   #define DMA_ADDR_HIGH_4BIT      GENMASK(3, 0)	/* RW */
> @@ -226,6 +232,7 @@
>   
>   /* MSDC_PATCH_BIT mask */
>   #define MSDC_PATCH_BIT_ODDSUPP    BIT(1)	/* RW */
> +#define MSDC_PATCH_BIT_RD_DAT_SEL BIT(3)	/* RW */
>   #define MSDC_INT_DAT_LATCH_CK_SEL GENMASK(9, 7)
>   #define MSDC_CKGEN_MSDC_DLY_SEL   GENMASK(14, 10)
>   #define MSDC_PATCH_BIT_IODSSEL    BIT(16)	/* RW */
> @@ -247,6 +254,8 @@
>   #define MSDC_PB2_SUPPORT_64G      BIT(1)    /* RW */
>   #define MSDC_PB2_RESPWAIT         GENMASK(3, 2)   /* RW */
>   #define MSDC_PB2_RESPSTSENSEL     GENMASK(18, 16) /* RW */
> +#define MSDC_PB2_POP_EN_CNT       GENMASK(23, 20) /* RW */
> +#define MSDC_PB2_CFGCRCSTSEDGE    BIT(25)   /* RW */
>   #define MSDC_PB2_CRCSTSENSEL      GENMASK(31, 29) /* RW */
>   
>   #define MSDC_PAD_TUNE_DATWRDLY	  GENMASK(4, 0)		/* RW */
> @@ -311,6 +320,12 @@
>   #define PAD_DS_DLY1		GENMASK(14, 10)	/* RW */
>   #define PAD_DS_DLY3		GENMASK(4, 0)	/* RW */
>   
> +/* LOOP_TEST_CONTROL mask */
> +#define TEST_LOOP_DSCLK_MUX_SEL        BIT(0)	/* RW */
> +#define TEST_LOOP_LATCH_MUX_SEL        BIT(1)	/* RW */
> +#define LOOP_EN_SEL_CLK                BIT(20)	/* RW */
> +#define TEST_HS400_CMD_LOOP_MUX_SEL    BIT(31)	/* RW */
> +
>   #define REQ_CMD_EIO  BIT(0)
>   #define REQ_CMD_TMO  BIT(1)
>   #define REQ_DAT_ERR  BIT(2)
> @@ -391,6 +406,7 @@ struct msdc_save_para {
>   	u32 emmc_top_control;
>   	u32 emmc_top_cmd;
>   	u32 emmc50_pad_ds_tune;
> +	u32 loop_test_control;
>   };
>   
>   struct mtk_mmc_compatible {
> @@ -402,9 +418,13 @@ struct mtk_mmc_compatible {
>   	bool data_tune;
>   	bool busy_check;
>   	bool stop_clk_fix;
> +	u8 stop_dly_sel;
> +	u8 pop_en_cnt;
>   	bool enhance_rx;
>   	bool support_64g;
>   	bool use_internal_cd;
> +	bool support_new_tx;
> +	bool support_new_rx;

Is there really any platform that supports new_tx but *not* new_rx, or vice-versa?

If not, you can add just one `bool support_new_rx_tx` member to this structure.

>   };
>   
>   struct msdc_tune_para {
> @@ -621,6 +641,23 @@ static const struct mtk_mmc_compatible mt8516_compat = {
>   	.stop_clk_fix = true,
>   };
>   
> +static const struct mtk_mmc_compatible mt8196_compat = {
> +	.clk_div_bits = 12,
> +	.recheck_sdio_irq = false,
> +	.hs400_tune = false,
> +	.pad_tune_reg = MSDC_PAD_TUNE0,
> +	.async_fifo = true,
> +	.data_tune = true,
> +	.busy_check = true,
> +	.stop_clk_fix = true,
> +	.stop_dly_sel = 1,
> +	.pop_en_cnt = 2,
> +	.enhance_rx = true,
> +	.support_64g = true,
> +	.support_new_tx = true,
> +	.support_new_rx = true,
> +};
> +
>   static const struct of_device_id msdc_of_ids[] = {
>   	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
>   	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> @@ -632,6 +669,7 @@ static const struct of_device_id msdc_of_ids[] = {
>   	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>   	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
>   	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
> +	{ .compatible = "mediatek,mt8196-mmc", .data = &mt8196_compat},
>   	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
>   
>   	{}
> @@ -872,6 +910,42 @@ static int msdc_ungate_clock(struct msdc_host *host)
>   				  (val & MSDC_CFG_CKSTB), 1, 20000);
>   }
>   
> +static void msdc_new_tx_setting(struct msdc_host *host)
> +{

That's simpler:

	if (!host->top_base)
		return;

> +	if (host->top_base) {
> +		sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
> +			     TEST_LOOP_DSCLK_MUX_SEL);
> +		sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
> +			     TEST_LOOP_LATCH_MUX_SEL);
> +		sdr_clr_bits(host->top_base + LOOP_TEST_CONTROL,
> +			     TEST_HS400_CMD_LOOP_MUX_SEL);
> +	}
> +
> +	switch (host->timing) {
> +	case MMC_TIMING_LEGACY:
> +	case MMC_TIMING_MMC_HS:
> +	case MMC_TIMING_SD_HS:
> +	case MMC_TIMING_UHS_SDR12:
> +	case MMC_TIMING_UHS_SDR25:
> +	case MMC_TIMING_UHS_DDR50:
> +	case MMC_TIMING_MMC_DDR52:
> +		if (host->top_base)
> +			sdr_clr_bits(host->top_base + LOOP_TEST_CONTROL,
> +				     LOOP_EN_SEL_CLK);
> +		break;
> +	case MMC_TIMING_UHS_SDR50:
> +	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_MMC_HS200:
> +	case MMC_TIMING_MMC_HS400:
> +		if (host->top_base)
> +			sdr_set_bits(host->top_base + LOOP_TEST_CONTROL,
> +				     LOOP_EN_SEL_CLK);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>   static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   {
>   	struct mmc_host *mmc = mmc_from_priv(host);
> @@ -881,6 +955,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   	u32 sclk;
>   	u32 tune_reg = host->dev_comp->pad_tune_reg;
>   	u32 val;
> +	bool timing_changed = false;

bool timing_changed;

>   
>   	if (!hz) {
>   		dev_dbg(host->dev, "set mclk to 0\n");
> @@ -890,6 +965,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   		return;
>   	}
>   
> +	if (host->timing != timing)
> +		timing_changed = true;

	else
		timing_changed = false;

> +
>   	flags = readl(host->base + MSDC_INTEN);
>   	sdr_clr_bits(host->base + MSDC_INTEN, flags);
>   	if (host->dev_comp->clk_div_bits == 8)
> @@ -996,6 +1074,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   		sdr_set_field(host->base + tune_reg,
>   			      MSDC_PAD_TUNE_CMDRRDLY,
>   			      host->hs400_cmd_int_delay);
> +	if (timing_changed && host->dev_comp->support_new_tx)

I would invert this to (host->dev_comp->support_new_tx && timing_changed)
as that, at least to me, reads as "if this is new_tx - and the timing changed"
maning that the primary reason why we're checking is "if this is new_tx".

It's a personal preference though, so the final choice is yours.

> +		msdc_new_tx_setting(host);
> +
>   	dev_dbg(host->dev, "sclk: %d, timing: %d\n", mmc->actual_clock,
>   		timing);
>   }
> @@ -1704,6 +1785,17 @@ static void msdc_init_hw(struct msdc_host *host)
>   		reset_control_deassert(host->reset);
>   	}
>   
> +	/* New tx/rx enable bit need to be 0->1 for hardware check */
> +	if (host->dev_comp->support_new_tx) {
> +		sdr_clr_bits(host->base + SDC_ADV_CFG0, SDC_NEW_TX_EN);
> +		sdr_set_bits(host->base + SDC_ADV_CFG0, SDC_NEW_TX_EN);
> +		msdc_new_tx_setting(host);
> +	}
> +	if (host->dev_comp->support_new_rx) {
> +		sdr_clr_bits(host->base + MSDC_NEW_RX_CFG, MSDC_NEW_RX_PATH_SEL);
> +		sdr_set_bits(host->base + MSDC_NEW_RX_CFG, MSDC_NEW_RX_PATH_SEL);
> +	}
> +
>   	/* Configure to MMC/SD mode, clock free running */
>   	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPDN);
>   
> @@ -1742,8 +1834,19 @@ static void msdc_init_hw(struct msdc_host *host)
>   	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
>   
>   	if (host->dev_comp->stop_clk_fix) {
> -		sdr_set_field(host->base + MSDC_PATCH_BIT1,
> -			      MSDC_PATCH_BIT1_STOP_DLY, 3);
> +		if (host->dev_comp->stop_dly_sel)
> +			sdr_set_field(host->base + MSDC_PATCH_BIT1,
> +				      MSDC_PATCH_BIT1_STOP_DLY,
> +				      host->dev_comp->stop_dly_sel & 0xf);

This doesn't look like being something to support new_tx and new_rx, but rather
a way to specify a different STOP_DLY depending on the SoC and its platdata.

So this one goes to a different commit, and you won't need either the 0xf masking
nor the `else`, as you will have to add the value to all SoCs' platdata instead.

> +		else
> +			sdr_set_field(host->base + MSDC_PATCH_BIT1,
> +				      MSDC_PATCH_BIT1_STOP_DLY, 3);
> +
> +		if (host->dev_comp->pop_en_cnt)
> +			sdr_set_field(host->base + MSDC_PATCH_BIT2,
> +				      MSDC_PB2_POP_EN_CNT,
> +				      host->dev_comp->pop_en_cnt & 0xf);
> +
>   		sdr_clr_bits(host->base + SDC_FIFO_CFG,
>   			     SDC_FIFO_CFG_WRVALIDSEL);
>   		sdr_clr_bits(host->base + SDC_FIFO_CFG,
> @@ -2055,6 +2158,19 @@ static inline void msdc_set_data_delay(struct msdc_host *host, u32 value)
>   	}
>   }
>   

Regards,
Angelo

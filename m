From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 15/18] mmc: meson-gx: improve initial configuration
Date: Wed, 15 Feb 2017 11:32:23 -0800
Message-ID: <m237ff8d2w.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <651c407e-bc38-5adc-a388-5a45854808e1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:32918 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdBOTc0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 14:32:26 -0500
Received: by mail-pg0-f45.google.com with SMTP id 204so39280934pge.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 11:32:26 -0800 (PST)
In-Reply-To: <651c407e-bc38-5adc-a388-5a45854808e1@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:07:05 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Config values which are not changed during runtime we can set
> in the probe function already.
> The block size setting is overwritten later in
> meson_mmc_start_cmd anyway if needed, so it doesn't harm if we
> remove this setting in meson_mmc_set_ios.
>
> In addition:
> - write config register only if configuration changed
> - Initialize clocks after other config registers have been initialized
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 806554b1..25b46d36 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -385,15 +385,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	val &= ~(CFG_BUS_WIDTH_MASK << CFG_BUS_WIDTH_SHIFT);
>  	val |= bus_width << CFG_BUS_WIDTH_SHIFT;
>  
> -	val &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
> -	val |= ilog2(SD_EMMC_CFG_BLK_SIZE) << CFG_BLK_LEN_SHIFT;
> -
> -	val &= ~(CFG_RESP_TIMEOUT_MASK << CFG_RESP_TIMEOUT_SHIFT);
> -	val |= ilog2(SD_EMMC_CFG_RESP_TIMEOUT) << CFG_RESP_TIMEOUT_SHIFT;
> -
> -	val &= ~(CFG_RC_CC_MASK << CFG_RC_CC_SHIFT);
> -	val |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
> -
>  	val &= ~CFG_DDR;
>  	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
>  	    ios->timing == MMC_TIMING_MMC_DDR52 ||
> @@ -404,11 +395,11 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (ios->timing == MMC_TIMING_MMC_HS400)
>  		val |= CFG_CHK_DS;
>  
> -	writel(val, host->regs + SD_EMMC_CFG);
> -
> -	if (val != orig)
> +	if (val != orig) {
> +		writel(val, host->regs + SD_EMMC_CFG);
>  		dev_dbg(host->dev, "%s: SD_EMMC_CFG: 0x%08x -> 0x%08x\n",
>  			__func__, orig, val);
> +	}
>  }
>  
>  static void meson_mmc_request_done(struct mmc_host *mmc,
> @@ -675,6 +666,17 @@ static int meson_mmc_get_cd(struct mmc_host *mmc)
>  	return status;
>  }
>  
> +static void meson_mmc_cfg_init(struct meson_host *host)
> +{
> +	u32 cfg = 0;
> +
> +	cfg |= ilog2(SD_EMMC_CFG_RESP_TIMEOUT) << CFG_RESP_TIMEOUT_SHIFT;
> +	cfg |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
> +	cfg |= ilog2(SD_EMMC_CFG_BLK_SIZE) << CFG_BLK_LEN_SHIFT;
> +
> +	writel(cfg, host->regs + SD_EMMC_CFG);
> +}
> +
>  static const struct mmc_host_ops meson_mmc_ops = {
>  	.request	= meson_mmc_request,
>  	.set_ios	= meson_mmc_set_ios,
> @@ -735,10 +737,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_host;
>  
> -	ret = meson_mmc_clk_init(host);
> -	if (ret)
> -		goto free_host;
> -
>  	/* Stop execution */
>  	writel(0, host->regs + SD_EMMC_START);
>  
> @@ -747,6 +745,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
>  	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
>  
> +	/* set config to sane default */
> +	meson_mmc_cfg_init(host);
> +
> +	ret = meson_mmc_clk_init(host);
> +	if (ret)
> +		goto free_host;
> +
>  	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
>  					meson_mmc_irq_thread, IRQF_SHARED,
>  					dev_name(&pdev->dev), host);

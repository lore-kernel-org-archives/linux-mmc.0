From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 5/5] mmc: meson-gx: switch to descriptor chain mode
Date: Fri, 24 Mar 2017 12:04:02 -0700
Message-ID: <m2bmsqijj1.fsf@baylibre.com>
References: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
        <57af6536-edf9-a2aa-40fe-a90338245d0e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36466 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934578AbdCXTEI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 15:04:08 -0400
Received: by mail-pf0-f180.google.com with SMTP id o126so4647866pfb.3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 12:04:07 -0700 (PDT)
In-Reply-To: <57af6536-edf9-a2aa-40fe-a90338245d0e@gmail.com> (Heiner
        Kallweit's message of "Wed, 15 Mar 2017 20:34:46 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Hi Heiner,

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Switch the driver from using a linearized bounce buffer to descriptor
> chain mode. This drastically improves performance.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

I know this series needs a respin on top of your other cleanups, and
I'll have a closer look at it then, but one comment for the respin...

[...]

>  static int meson_mmc_probe(struct platform_device *pdev)
> @@ -764,15 +790,14 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  
>  	mmc->caps |= MMC_CAP_CMD23;
>  	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
> -	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
> -
> -	/* data bounce buffer */
> -	host->bounce_buf_size = mmc->max_req_size;
> -	host->bounce_buf =
> -		dma_alloc_coherent(host->dev, host->bounce_buf_size,
> -				   &host->bounce_dma_addr, GFP_KERNEL);
> -	if (host->bounce_buf == NULL) {
> -		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
> +	mmc->max_segs = PAGE_SIZE / sizeof(struct sd_emmc_desc);
> +	mmc->max_seg_size = mmc->max_blk_count * mmc->max_blk_size;
> +	mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
> +
> +	host->descs = dma_alloc_coherent(host->dev, PAGE_SIZE,
> +					 &host->descs_dma_addr, GFP_KERNEL);
> +	if (!host->descs) {
> +		dev_err(host->dev, "Allocating descriptor DMA buffer failed\n");
>  		ret = -ENOMEM;
>  		goto err_div_clk;
>  	}
> @@ -797,8 +822,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
>  	/* disable interrupts */
>  	writel(0, host->regs + SD_EMMC_IRQ_EN);
>  
> -	dma_free_coherent(host->dev, host->bounce_buf_size,
> -			  host->bounce_buf, host->bounce_dma_addr);
> +	dma_free_coherent(host->dev, PAGE_SIZE, host->descs,
> +			  host->descs_dma_addr);
>  
>  	clk_disable_unprepare(host->cfg_div_clk);
>  	clk_disable_unprepare(host->core_clk);

Please replace the usage of PAGE_SIZE above with a #define at the top of
the driver for the max number of descriptors/segments.  Right now, if
you wanted to change that, you'd have to change it in at least three
places.

Kevin


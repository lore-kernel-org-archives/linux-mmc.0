Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23584C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26BB64FDD
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 18:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCKSoZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCKSoS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 13:44:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1DC764F8E;
        Thu, 11 Mar 2021 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615488258;
        bh=DYeHy66eRup4CHRWH3huzJ01TuQ0LiVd36jb05cmqtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqDIySRP0vQlPsZPkbyRFvxvrTmFX/4zLvht6cRb/e3TaGR3QUqqhOujaLXm+ttrF
         IMGVB0/i2UInSWaAf0crs3X9SiWhXQ6UdSQucSvIwS3njLuuaMvGGTOClRfySpY43O
         nVn3666rASt+UfvVQTxeDd9oKNIGO2z9vTYVCU4wQOBtoyQYKmCfkOJCV9gXmsyZnn
         MqMQ5D87ZnvZYNMECrC8RIfCGQk9PZ6ycDs+hGc9pTWS5aPLmXEupVgGI+nVRVh9iE
         W/s+cUViySMLb92twqaZhTR9QZ8nSK+DFjqsvauF5XuM3XF9WyhA8ZeZMIdbh0akZy
         vZuDreChI0o7g==
Date:   Thu, 11 Mar 2021 10:44:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>
Subject: Re: [PATCH v2 1/4] mmc: Mediatek: add Inline Crypto Engine support
Message-ID: <YEpk//tPRS47tLij@gmail.com>
References: <20210309015630.19545-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309015630.19545-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 09, 2021 at 09:56:31AM +0800, Peng Zhou wrote:
> 1. add crypto clock control and ungate it before CQHCI init
> 
> 2. set MMC_CAP2_CRYPTO property of eMMC
> 
> Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 898ed1b023df..1c90360d6cf2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -442,6 +442,7 @@ struct msdc_host {
>  	struct clk *src_clk_cg; /* msdc source clock control gate */
>  	struct clk *sys_clk_cg;	/* msdc subsys clock control gate */
>  	struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];
> +	struct clk *crypto_clk; /* msdc crypto clock */
>  	u32 mclk;		/* mmc subsystem clock frequency */
>  	u32 src_clk_freq;	/* source clock frequency */
>  	unsigned char timing;
> @@ -802,6 +803,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
>  
>  static void msdc_gate_clock(struct msdc_host *host)
>  {
> +	clk_disable_unprepare(host->crypto_clk);
>  	clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host->bulk_clks);
>  	clk_disable_unprepare(host->src_clk_cg);
>  	clk_disable_unprepare(host->src_clk);
> @@ -822,6 +824,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
>  		dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
>  		return;
>  	}
> +	clk_prepare_enable(host->crypto_clk);
>  
>  	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>  		cpu_relax();
> @@ -2512,6 +2515,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	/* only eMMC has crypto property */
> +	if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 & MMC_CAP2_NO_SDIO)) {
> +		host->crypto_clk = devm_clk_get(&pdev->dev, "crypto");
> +		if (IS_ERR(host->crypto_clk))
> +			host->crypto_clk = NULL;
> +		else
> +			mmc->caps2 |= MMC_CAP2_CRYPTO;
> +	}
> +
>  	host->irq = platform_get_irq(pdev, 0);
>  	if (host->irq < 0) {
>  		ret = -EINVAL;
> @@ -2582,6 +2594,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		host->dma_mask = DMA_BIT_MASK(32);
>  	mmc_dev(mmc)->dma_mask = &host->dma_mask;
>  
> +	/* here ungate due to cqhci init will access registers */
> +	msdc_ungate_clock(host);
>  	if (mmc->caps2 & MMC_CAP2_CQE) {
>  		host->cq_host = devm_kzalloc(mmc->parent,
>  					     sizeof(*host->cq_host),
> @@ -2618,7 +2632,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	spin_lock_init(&host->lock);
>  
>  	platform_set_drvdata(pdev, mmc);
> -	msdc_ungate_clock(host);
>  	msdc_init_hw(host);

I'm still not able to apply this patch.  You can see yourself if you check out
v5.12-rc2 (or mmc/next), download this email from lkml.kernel.org
(https://lkml.kernel.org/linux-mmc/20210309015630.19545-1-peng.zhou@mediatek.com/raw),
and use 'git am'.  It's probably related to the email being base64-encoded,
which it shouldn't be.

Also, this patch series isn't in a thread, so it's hard to follow.

Please make sure you use 'git format-patch --cover-letter v5.12-rc2..@' or
similar, and then 'git send-email', passing it all the patches (including the
cover letter) at once.  And please make sure that your company's mail server is
set up to properly handle plaintext email.

Thanks,

- Eric

Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FABAC433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B6B64E60
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhCCB3o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577010AbhCBFfh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 00:35:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED647C061221
        for <linux-mmc@vger.kernel.org>; Mon,  1 Mar 2021 21:33:14 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p5so11366661plo.4
        for <linux-mmc@vger.kernel.org>; Mon, 01 Mar 2021 21:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QlVGLrkHIuUSrMOT86XjP1lDUQ4YVXSQssLeyeB3P2w=;
        b=s3u3zOqN+5mSihsKV0/UUHtIUFDp0I1NrNhtMYDJddNEcFe/vZpWFUiQzXcWKIjUzL
         DA3MdrxTgGITpruaO2y8qFb+j7KBolTK3NwIlo5NaNCwN7qtirNMf3KwqBir441YhdUQ
         SXxCZatVIFXMvzp6CW2mQeeD8lH0qPkF5PY/cl3uzcggLd/MA1c7ZNNiqQPxFA0CH2Bl
         SCwm+TtTSOGx2wLS0avUXgsRJEBVfLHkQLOSeTymJj9SN2lRQRQ59ysVS54q7Wxtvu1/
         c0k2JpYSPaWp7dLB9uhGmGWoDO9J2Tl1/rn59+c+4gExzIAiua9oDJ1wDbIwz/1NLAEl
         jpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QlVGLrkHIuUSrMOT86XjP1lDUQ4YVXSQssLeyeB3P2w=;
        b=QcL1NGLLCRv/PmvB607xfdeDa2IFsxSVhJXYVClXU80BpAo7kJoH1tbU9abysxgG8O
         EHovbpFGBhkmbW1v3qjmq3IuOFhl66XjZJKS8QCjthbpEn8nnOlB/GxmenZ7XBNMeNua
         6bgG16rKkuwvu/GfAXls5NmsKVmeO/3wPr+Ol+ykvYsUwFFSTREn/+Shu5nHWU2E1y9Q
         Q43zvqP/nTAoaWuiJi3YdwSjhqG8qSkgJFUpBIuAnHhzqxW44xyi0760X3O6SXeB7T3r
         o3xCmPpg2AL41d3P2Ns0LpQQxcIRrj4NOoPQAKBksXd+oQfVt41gcwiYP8H6R/JWEt5k
         It2Q==
X-Gm-Message-State: AOAM531C36s82zeRqFJ9GFz8HFP113abN2yK63082phAkwOnDjakQKz+
        MXzmd1D10krcrwcja9XPo2Zg+Q==
X-Google-Smtp-Source: ABdhPJymEZ3Tl3oz31AARFwRD5fs9K1aC/aaVoA8JvRVQ1xUXd54+SmhpfZlqk5+sTkGNH4d+F/3DA==
X-Received: by 2002:a17:90a:d14c:: with SMTP id t12mr2417845pjw.5.1614663194409;
        Mon, 01 Mar 2021 21:33:14 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id i7sm1381624pjs.1.2021.03.01.21.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 21:33:14 -0800 (PST)
Date:   Tue, 2 Mar 2021 05:33:10 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>
Subject: Re: [PATCH 1/4] mmc: mediatek: add Inline Crypto Engine support
Message-ID: <YD3OFkjS8a6EUOHM@google.com>
References: <20210302024557.4868-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302024557.4868-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 02, 2021 at 10:45:57AM +0800, Peng Zhou wrote:
> - add crypto clock control and ungate it before CQHCI init
> - set MMC_CAP2_CRYPTO property of eMMC
> 
> Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index de09c6347524..1a5894ec551f 100644
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
> @@ -822,7 +824,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
>  		dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
>  		return;
>  	}
> -
> +	clk_prepare_enable(host->crypto_clk);
>  	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>  		cpu_relax();
>  }
> @@ -2510,6 +2512,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	/* only eMMC has crypto property */
> +	if ((mmc->caps2 & MMC_CAP2_NO_SD) &&
> +	    (mmc->caps2 & MMC_CAP2_NO_SDIO)) {
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
> @@ -2580,6 +2592,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		host->dma_mask = DMA_BIT_MASK(32);
>  	mmc_dev(mmc)->dma_mask = &host->dma_mask;
>  
> +	/* here ungate due to cqhci init will access registers */
> +	msdc_ungate_clock(host);
>  	if (mmc->caps2 & MMC_CAP2_CQE) {
>  		host->cq_host = devm_kzalloc(mmc->parent,
>  					     sizeof(*host->cq_host),
> @@ -2616,7 +2630,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	spin_lock_init(&host->lock);
>  
>  	platform_set_drvdata(pdev, mmc);
> -	msdc_ungate_clock(host);
>  	msdc_init_hw(host);
>  
>  	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> -- 
> 2.18.0
Somehow I can't apply this patch using git am. It looks like the mail
isn't completely plain text (there's some html it seems), which may be
why git am is complaining.

Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440BC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 10:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE18364F76
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 10:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCJKep (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 05:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCJKeo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2021 05:34:44 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C3C06174A
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 02:34:43 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m11so24873267lji.10
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 02:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PWsBNa17zFFbX5pQPj28HEPvIzD8iLvjdf7cvgUKZAc=;
        b=h/rjgSKjtOPaokmW/Wxd2af4y6iFXdiil64wC1WgmbB1PU4Bc/7Z82IwFiEqZfNrsQ
         2CF0eSmm8dDM1yJSa+hYetsHsgrZfMHMKyfilslKJ70E7xXRi+A4zl0TfyLjO669vfTU
         dNHYl16Tog1VIHPsQpgRyPI6rRupLW3G2IlV4yyhXt+r+sKgkAAyQJIeANNaCCQn9DA+
         RNDzmfmb1WsS2Yd1ss2UaAIHkeU/kW7P6w0Yqbg10azDDVKE4bTaUd6EFJe0+f/+yk1T
         jO5uB7TF+4Y9bthum58ev6/k2yefCR0jmEWjjj6ofvNZt6+Bp39KY7ShS7SEUNoLR25y
         ij1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PWsBNa17zFFbX5pQPj28HEPvIzD8iLvjdf7cvgUKZAc=;
        b=q3ShRHLkhYaqcTfP7aP0cdr6i64/ZjS/JKe3CmKvMTEtym3bNf1N2VBPlX8NsvSIvn
         a6J8v97ng+D367fB364FI/AVBTXRMK2zHhaq6bx0DvKcl3g9rHqdr7u7StPPZ09EJkuq
         OqOV02K24pM7Z9eKJW/q+l+yrCsL31kOzBbWFw1QFDRxANmrK4W3OR0IRTxGF2UkT5YK
         KHIf4Hy+s/mRsa8CwPBYqyVTL23DLf6GrbULMgrdIy35oWwhENixpoiWjlScXjOEqvjP
         aho1h1XX6/IHLyKnIrcfsfooNN/K/qDsAAjnhR+BjWOXNWrzQuMehEp8YDdWcUiv0iKr
         XDLA==
X-Gm-Message-State: AOAM5312bxYTQPvHLYMQzzFo9PIS+3t+CUn+RMk2gLyNKArZm8OAWE7h
        at0yd5nG+ddIrAwWTp5M2TTl9ovD9OFutg==
X-Google-Smtp-Source: ABdhPJzlp9pTxknKie81xrXQaug5Sm6YfQEMdTMTxaQ7YZTK5knNmAwXlwsLiDw5BnzEc7Lwcp/rYQ==
X-Received: by 2002:a2e:900b:: with SMTP id h11mr1438577ljg.258.1615372482168;
        Wed, 10 Mar 2021 02:34:42 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id h26sm3035757ljc.17.2021.03.10.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 02:34:39 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:34:38 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] mmc: tmio: abort DMA before reset
Message-ID: <YEigvgfGVUmeG/vP@oden.dyn.berto.se>
References: <20210309092332.30705-1-wsa+renesas@sang-engineering.com>
 <20210309092332.30705-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309092332.30705-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your patch.

On 2021-03-09 10:23:31 +0100, Wolfram Sang wrote:
> We will soon allow resetting the whole IP core via a reset controller.
> For this case, DMA must be terminated before the actual reset. For the
> other cases, it is probably better, too.

I agree I think it makes more sens to abort dma before reseting the 
device.

> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/tmio_mmc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 5aa57640d0e6..eca767dcabba 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -172,11 +172,11 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
>  	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
>  	usleep_range(10000, 11000);
>  
> +	tmio_mmc_abort_dma(host);
> +
>  	if (host->reset)
>  		host->reset(host);
>  
> -	tmio_mmc_abort_dma(host);
> -
>  	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
>  		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
>  		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
> -- 
> 2.30.0
> 

-- 
Regards,
Niklas Söderlund

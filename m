Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957ACC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E0820776
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKXLgYnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbgE1KPX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgE1KPG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:15:06 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B941CC08C5C7
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:06 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id v26so15466296vsa.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NnFvkEinSu8JNeeiaCqqDDP3KthjxwCRXHN9I0khteE=;
        b=JKXLgYnRrXprs68FC8fP4Hq7I9VPldQJYeOyc/9tZMIvKGkf3t5OoImS5K4atsMnAN
         r27FPxAuUszQNOJP2Mc0e0W6PepVkbJr7xfkUcfmu59eRZHeKzQsqFqgPrCLjhZ2QcZm
         B98a7+5hvdsR4PehdNAbX2Q5Irc8IRfgouLxpRWRu9GLQmRxE+zYRiXyI51m7zoRSkTJ
         +rswdazaCjsE26eujh5yTeYERp1E0iZsmhEVLg3VEOfm4tqR8fEEMp3c4DUPAf0RW48B
         6C4TICJ1VGKAY2wPQ1LKT6XGF2yPvJNdhTWDNUDY6Dvh2AZDUdM0GPcSLgQ5yRXyb7ex
         BfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnFvkEinSu8JNeeiaCqqDDP3KthjxwCRXHN9I0khteE=;
        b=Ysb+tKVXP4Sxg561RFvX+ahlTr18LbeI4ZjFwT+Z7V6LMTFT3BexQcWHxfRXw4AezI
         NC9SabMk2goLRZqZdl+fsUCdckFR6Vk+5iFje9ittp7+Gn+lwHt4ku/AzjN6C1yC8d5v
         JA71FHbus6Wzr7jM8yCmKHuGsrYEoMnWrz4/PncXqzoLRy2ceON3HgMQNoTiAONqa5ut
         ZRateCmP49TwgasnB6Tpew+d9VB/+XjdokU1jMCTzn2LfaUsjnykfxQGWI7wF/YOu/5A
         N6cSVKaLXtvh4R+MJtInae7MTDH2WYNZHi2m0FUe3LT/H/TGIS/ain9+1J4tycYqb9TA
         Pw6w==
X-Gm-Message-State: AOAM533sEAUONGnsON5Lx6IWe+aDtr+xa+Uf7PO+r5HJQFSPrWt2iP0o
        8SWizVE1NWRgX4Di8AsiM7U+9VAYKy4t639h3BS2Jg==
X-Google-Smtp-Source: ABdhPJzVo18IfEZvDNjehMuUK+Er1KC2DxaDvMSbNlAbvNzpRPVY17HtVDdF3JBPl18RRNoiV/BlCC6N4HoAjWTgSlA=
X-Received: by 2002:a67:ec58:: with SMTP id z24mr1378822vso.200.1590660905952;
 Thu, 28 May 2020 03:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200526155103.12514-1-ludovic.barre@st.com> <20200526155103.12514-3-ludovic.barre@st.com>
In-Reply-To: <20200526155103.12514-3-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:28 +0200
Message-ID: <CAPDyKForRHZFGEzn=5OVY8YP6okFj7G2e6QTJFH5-Q_xP3QLBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: mmci_sdmmc: fix DMA API warning max segment size
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 May 2020 at 17:51, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:
> WARNING: CPU: 1 PID: 85 at kernel/dma/debug.c:1302 debug_dma_map_sg+0x2a0/0x3cc
> mmci-pl18x 58005000.sdmmc: DMA-API: mapping sg segment longer than device claims to support [len=126976] [max=65536]
>
> dma api debug checks and compares the segment size to
> dma_get_max_seg_size (dev->dma_parms->max_segment_size),
> the sdmmc variant has an internal DMA and should define
> its max_segment_size constraint to avoid this warning.
>
> This Patch defines the dev->dma_parms->max_segment_size
> with the constraint already set for mmc core
> (host->mmc->max_seg_size).
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Note, a manual backport is needed for stable, as
dma_set_max_seg_size() will fail for older kernels.
We needed to revert 9495b7e92f7 ("driver core: platform: Initialize
dma_parms for platform devices"), for stable kernels [1].

Kind regards
Uffe

[1]
https://lkml.org/lkml/2020/5/26/1216


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 2965b1c062e1..51db30acf4dc 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -119,20 +119,19 @@ static void sdmmc_idma_unprep_data(struct mmci_host *host,
>  static int sdmmc_idma_setup(struct mmci_host *host)
>  {
>         struct sdmmc_idma *idma;
> +       struct device *dev = mmc_dev(host->mmc);
>
> -       idma = devm_kzalloc(mmc_dev(host->mmc), sizeof(*idma), GFP_KERNEL);
> +       idma = devm_kzalloc(dev, sizeof(*idma), GFP_KERNEL);
>         if (!idma)
>                 return -ENOMEM;
>
>         host->dma_priv = idma;
>
>         if (host->variant->dma_lli) {
> -               idma->sg_cpu = dmam_alloc_coherent(mmc_dev(host->mmc),
> -                                                  SDMMC_LLI_BUF_LEN,
> +               idma->sg_cpu = dmam_alloc_coherent(dev, SDMMC_LLI_BUF_LEN,
>                                                    &idma->sg_dma, GFP_KERNEL);
>                 if (!idma->sg_cpu) {
> -                       dev_err(mmc_dev(host->mmc),
> -                               "Failed to alloc IDMA descriptor\n");
> +                       dev_err(dev, "Failed to alloc IDMA descriptor\n");
>                         return -ENOMEM;
>                 }
>                 host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
> @@ -143,7 +142,7 @@ static int sdmmc_idma_setup(struct mmci_host *host)
>                 host->mmc->max_seg_size = host->mmc->max_req_size;
>         }
>
> -       return 0;
> +       return dma_set_max_seg_size(dev, host->mmc->max_seg_size);
>  }
>
>  static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
> --
> 2.17.1
>

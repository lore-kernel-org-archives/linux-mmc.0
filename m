Return-Path: <SRS0=qSan=CQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA9C433E2
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F59C215A4
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xV6+1KcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgIGKHx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgIGKHt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2020 06:07:49 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E7C061574
        for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2020 03:07:49 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id b4so3163297vkh.9
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2020 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohQz2mjWvKPSQs/ENMQ7fjx0MMWY/LDMUDMVUXfjt80=;
        b=xV6+1KcFPRx+/Lx09wE1O/OwgbBU3YpXopPUr9n/xREbf/c91nXEB8juYkabfHfzzv
         vB+/EMZHZ2kW/NHEBUXaz6j3Z9EMzAjwx99dk4XKIHSKgmCVuRAMVcBV6k9CcuWjhNzj
         SFoWgfSoRBqp/BEmTlVQdZXn86N1niJnfIgO0oSeQWuudLhUME/0aTljHWe53bqd2OIw
         Lv1B9qRb6c4O1OqnTQD1GoxNqqg+pkszFXTgHoWHkzO8Wtq4oPi8bxUmTmLrP52RxjU6
         friPrT8d4Ys5HsfkEB0/TH4LmWWEPxpGkl6vIsDEiEgyvAJD17j6pgXtndmtNZQn7Jgg
         CYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohQz2mjWvKPSQs/ENMQ7fjx0MMWY/LDMUDMVUXfjt80=;
        b=t8nVdl983auIthXY+gnmFhqVpviErlQl1dMHms0hVw/soX1w+BnKmdPA96uHoS9oXX
         qDYB02mCPqjqZKq7tFOCEqkDD6jZ1gIkFr3u9abrwl+/WhtdGKPLhRaSAemOlHcrXxqq
         TtrvSj1DZARGbIcHJRse0Ynj6NgztfBP+iuG5PCi1qBvY+Lo06SJ1Ttek/amu5rtk/jJ
         Y4V/th1GwsUf72UzQ1jHoozP2C1HZrwxJlb/4Dtovl/TFlH0PVmBIi1pz6ylPJtDwT+G
         D+Oz4jZnLDgkhyC/OxBEFJEX96GSvcwcgKTnaafvXjbqSC4mXwuZiW20oiCjy1RJxuVl
         MxZw==
X-Gm-Message-State: AOAM530H6PoakHx4/FNGGlCJ78OFRl5zzixlrG5jneEIbzrZtsdfqs5N
        NeZDB3xn7m35zVPJmHvWlfDmaU/nzkVIzvkvk2bHFMCxKESfKw==
X-Google-Smtp-Source: ABdhPJynaggktEbLu38BdATjWS1S2E8VHdp21BI+BaFMEtcxXN8NSu4mhbKbaJGHCsiPLXjFOLrlCfawtT2fvxFEqRc=
X-Received: by 2002:a1f:e443:: with SMTP id b64mr11582388vkh.17.1599473268258;
 Mon, 07 Sep 2020 03:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <85e1fc97dbec3dea96102785a5e308ccb5e91cfe.1599167798.git.robin.murphy@arm.com>
In-Reply-To: <85e1fc97dbec3dea96102785a5e308ccb5e91cfe.1599167798.git.robin.murphy@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Sep 2020 12:07:12 +0200
Message-ID: <CAPDyKFpiwNJQVnZObqT2+6u=L3FLp4-QnOu_ooioNjcXXthA9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Drop local dma_parms
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Sep 2020 at 23:18, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Since commit 9495b7e92f71 ("driver core: platform: Initialize dma_parms
> for platform devices"), struct platform_device already provides a
> dma_parms structure, so we can save allocating another one.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 32ab991544ef..8ee6b2b85ec2 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -336,10 +336,6 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>         if (soc)
>                 global_flags |= (unsigned long)soc->data;
>
> -       dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);
> -       if (!dev->dma_parms)
> -               return -ENOMEM;
> -
>         /* value is max of SD_SECCNT. Confirmed by HW engineers */
>         dma_set_max_seg_size(dev, 0xffffffff);
>
> --
> 2.28.0.dirty
>

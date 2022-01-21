Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653EEC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Jan 2022 14:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350613AbiAUOch (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Jan 2022 09:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbiAUOcg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2022 09:32:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33042C06173D
        for <linux-mmc@vger.kernel.org>; Fri, 21 Jan 2022 06:32:36 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x7so34242283lfu.8
        for <linux-mmc@vger.kernel.org>; Fri, 21 Jan 2022 06:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSnD3reN29Xyx0ktcQx+JaAuK35n5napZ9h5xMh7Qwc=;
        b=azcO1MJ8CS74CpAJee7gm9xKMmwn31bekVcg1RdHRnZGGrPmDr183W5RrXgX0WY9QC
         u7nGTCcDk2FNSjb9+BNJziMG8+xyL9kyAPXVE0yHwywO2MwhElFzs2kk41/OQ8hXqGVr
         DSuVUlUPe2dUYI10nn0ZNJZmlAEq7n2UBVlZLJ+r08qJ4J0gR+hV81hEqinZYXvj0aFI
         GBcOzPRnwy1e9A4yktvkKwXfpTBXCoJ90rC6wuo97HUMIrZTJsl3xM2ZOjt9pBg/s8xd
         4vEZnbMnKmhhzvWcebl4pfn4LxoyT7zceFfp3jYKdnFS35VzFKkCYaXTQfWuNgjHHnqJ
         AH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSnD3reN29Xyx0ktcQx+JaAuK35n5napZ9h5xMh7Qwc=;
        b=P0X+L3qD4/zCTdD16XOtMZCC/E/loa6Pqzvgq3mVr2/IHJ/twDwaI43P1LpPRxPRFI
         gKEtJb0HC7gE9LKCsD0QLSbBgwKO3K3cx7lyybDNghNGVcvsLxDtgSAcwdKol0XC7iRQ
         HsYrfMPjQ/D2Gfa1T2Kg7wRFhM0uY5pPfRhtCo5GQYjTMWfAjygw864o0O+i60TfihUV
         JTJoGIJdvPZN7bHLWSDPYhnucHS2EDw9zObR7UA10jDwtZlq3y4mvEXcaAPVeQ75BP9q
         cQJjQAibb+9yiWuPa6VgTnGs6pTW/V4+tcp5SN9aJD2EBqxp5F76suQr9wt4wQ07x2kr
         wWXg==
X-Gm-Message-State: AOAM530BGy1l74tK/WpLq1QyNGBVnYBXiBvLJQUGXsG0cTMBEhrBZP8S
        F3bnctdMMvTfk9Ult2dl741reMXMmRRoB3sRUjSBA0iRq9g=
X-Google-Smtp-Source: ABdhPJx65Ge7/vIE6/W7wpMHNbwfxSWP9vI2IG2rRQZZBAsDmMiO8mvgljYuS3lH/TgLsAnJNxG9w6E69FmO2GfrDi0=
X-Received: by 2002:a05:6512:10d2:: with SMTP id k18mr3809962lfg.167.1642775554555;
 Fri, 21 Jan 2022 06:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20220112083156.1124782-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220112083156.1124782-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jan 2022 15:31:58 +0100
Message-ID: <CAPDyKFpJ3i4QrraziGNn+dMn_0GipHPsKeMxqJ4cNVpm0GYmXg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: Check for error num after setting mask
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Jan 2022 at 09:32, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> Because of the possible failure of the dma_supported(), the
> dma_set_mask_and_coherent() may return error num.
> Therefore, it should be better to check it and return the error if
> fails.
> And since the sdhci_setup_host() has already checked the return value of
> the enable_dma, we need not check it in sdhci_resume_host() again.
>
> Fixes: 5552d7ad596c ("mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changelog
>
> v1 -> v2
>
> * Change 1. Remove the change of esdhc_of_resume and refine the commit
> * message.
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index a593b1fbd69e..0f3658b36513 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -524,12 +524,16 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>
>  static int esdhc_of_enable_dma(struct sdhci_host *host)
>  {
> +       int ret;
>         u32 value;
>         struct device *dev = mmc_dev(host->mmc);
>
>         if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
> -           of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
> -               dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +           of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc")) {
> +               ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> +               if (ret)
> +                       return ret;
> +       }
>
>         value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>
> --
> 2.25.1
>

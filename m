Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27FCCD8C8E
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Oct 2023 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjJJO2M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJJO2K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 10:28:10 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D8CCF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:28:09 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7afd45199so16170107b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696948088; x=1697552888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=alViJn9wr9hEami8tBTxM86DiA2WqQugL84JflHHVFE=;
        b=TADHbS7ShwdgF5AOUuae7PRNM2y/+3XUGtoETm1A8TJV0MGjyM/NMdGx89pe+crK8z
         VAIyDHEgMPYmsGmRSE+vU4M/AV+JIqdvZ0Y63KHUQCcyd2ehW1vH4baYvBHLIv6zrfE7
         oLwHVxC7tAoZ2uutx1/WadF4CSl1onHmb/oxQyatUFGp5/3pITf3XusbYGFoUD2fksbj
         6z794f8Pcx+bnvDb2ogWhobwgJSg1E48wse3//6hQzBf+0GQI4m5oR248sUv1MBdLcOk
         m+Bzds9j9brXcthGe+2bgW2NRzmKLIGWLAP8AQBcwfXoCP7Y7Q6pSHsfaqqXem6aeE6u
         WHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948088; x=1697552888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alViJn9wr9hEami8tBTxM86DiA2WqQugL84JflHHVFE=;
        b=TB5gGo8wDgiU7OPPMXtSSJkAF8UWSNGREcU1q8CAILp1ErGAkurHNv7bGamU1oPSt1
         pWEKmPLKesIeHxVy6ADOY9t/dX9+zl71TRkNy34d179Gm5hiMjFLFFEb7FJuXE25lMQ/
         E/yEeKjABzG/HCaz5HB6mm9UfD60EW4BZysB83aH0QatSJh0aWw9+hRYExjZIqVVAEhV
         ewvtqm4I8QuzTOKrSeFBH8Z4YgsyrBOrCqp5kUKzlK/GSatcH6AMamhSNHAKn/SJq/zl
         NbS7xzqstTHmuqKsfPbjpcU3yZzLP2MLdj/PvzrRimL93ETRaVGVRrzaiCUzzEju7p9b
         //iA==
X-Gm-Message-State: AOJu0YwUUuN+lQ14hP4iXpZ0XcicLpPr01hpQPp4v+mOeBctH7EdImQw
        FA96CzyYcdQm09vezShFRBWQhavluGBUc77t5UkBOA==
X-Google-Smtp-Source: AGHT+IGCuVm5tfzzCQRJLgAPe/QFgRUKObDDu9q6XLFDHXNneXmxPF+QjDjGrUh+AlHyp3RMyudNaztMFnoej3Pvy94=
X-Received: by 2002:a25:cd45:0:b0:d91:1296:947 with SMTP id
 d66-20020a25cd45000000b00d9112960947mr14699613ybf.40.1696948088333; Tue, 10
 Oct 2023 07:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 16:27:32 +0200
Message-ID: <CAPDyKFodA+MS_B8XNAr--R0Zq3LNYARfVHN9bgoo=_opU8=O4w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: sdhci-pltfm: Drop unnecessary error messages
 in sdhci_pltfm_init()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Oct 2023 at 12:58, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The devm_platform_ioremap_resource() and platform_get_irq() print
> the error messages themselves and our "failed" one brings no value
> and just noise. Refactor code to avoid those noisy error messages.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pltfm.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a72e123a585d..4d1a703a5bdb 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -115,26 +115,21 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  {
>         struct sdhci_host *host;
>         void __iomem *ioaddr;
> -       int irq, ret;
> +       int irq;
>
>         ioaddr = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(ioaddr)) {
> -               ret = PTR_ERR(ioaddr);
> -               goto err;
> -       }
> +       if (IS_ERR(ioaddr))
> +               return ERR_CAST(ioaddr);
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               ret = irq;
> -               goto err;
> -       }
> +       if (irq < 0)
> +               return ERR_PTR(irq);
>
>         host = sdhci_alloc_host(&pdev->dev,
>                 sizeof(struct sdhci_pltfm_host) + priv_size);
> -
>         if (IS_ERR(host)) {
> -               ret = PTR_ERR(host);
> -               goto err;
> +               dev_err(&pdev->dev, "%s failed %pe\n", __func__, host);
> +               return ERR_CAST(host);
>         }
>
>         host->ioaddr = ioaddr;
> @@ -152,9 +147,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>         platform_set_drvdata(pdev, host);
>
>         return host;
> -err:
> -       dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
> -       return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
>
> --
> 2.40.0.1.gaa8946217a0b
>

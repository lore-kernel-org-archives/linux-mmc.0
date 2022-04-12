Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496ADC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 14:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356681AbiDLOlZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355889AbiDLOlY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 10:41:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D2E5B
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:39:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x17so23469274lfa.10
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jW4bd/7yPSEehPFbVTpAiA6p53vC49A6nWZuDG/r3o=;
        b=R+7xlx0FffmlF26JaLRk5I7U2ZMzLBkIwDNugQkPqgvHR3dbVGsuN5g618Ql7GwUEs
         k2oEKEpUzgQzyS4GWBDy27jyyanEP9a0Aox9ZO+Piq1Yif2/LWhM/b5rx0Rey3LN8NBv
         n1znTZbdaBD7K93N+/Ubqx2waufdfZTnF2CTNcMTfDo36iDb7UHLojMwkUiTJpEMIQfK
         yawMuwJmxYIqZquOJz/fMQdLdWFOpZ8w1yL/AiVFZyPDJir8ioNtk0c7jhNnnHOg1BlS
         xcK0lQcnpM2qZ18z+cRs+Ys2z7sBIU7Wn7M8xiFDBAeQZCuyGQ7hn7Tq/t+vn3C+EQ3T
         X9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jW4bd/7yPSEehPFbVTpAiA6p53vC49A6nWZuDG/r3o=;
        b=7R1TpXEPbWPkgYN+HTHL547QMfLFUxTtkegdGVpPNS9V25XLaTj2Tx7Mad6ThEDOJa
         gZ0Mbx+SbSQOcxu883GWEJi5Av/gqQmwUtyI7ryDOCos/mvAUcRv56odAQNAsHL+466j
         nQyae+s8K/YSuChimZ4E//pdKkSLBE67k01fVkH6K5VZnJbWgE8auAuwWecwbioQHeuq
         KeU7LPbHFW11fv4ltQWxfDQ8UzoGIbYZvUZHc9j1u1L3Pq90PrvLjZpNp4OneuZhdYg1
         nx4jXHCkquLeQvKoQKLEShYRLcyRiqJXjyZP1f42SzlgT4RDfzW9+Vgws0B8dlZpUDG8
         s77A==
X-Gm-Message-State: AOAM532VUqIkIwUsVQnf/OEe6HYLrUigO0X0XrF+FlWQHHeJY6MUnLCA
        l6RMgEXdTEw04Th3OnXrkCFXA8AZFDlWWPuaLMUoYQ==
X-Google-Smtp-Source: ABdhPJyTqqiHyWMmyXbnPNp/p5Xp2ZhfTyIjgr++ep+ra07cLmtyTcrBj9MXWwiVc5yBowR4nPuQy+3S81ngAu0lnHU=
X-Received: by 2002:a05:6512:b19:b0:44a:b7c4:3d94 with SMTP id
 w25-20020a0565120b1900b0044ab7c43d94mr24488580lfu.358.1649774344300; Tue, 12
 Apr 2022 07:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220408124338.27090-1-a-govindraju@ti.com>
In-Reply-To: <20220408124338.27090-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 16:38:28 +0200
Message-ID: <CAPDyKFqy6sEtU57-QkZeCfMtJgcoHG8siRBieOUjkBZMfPge9Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2] mmc: sdhci_am654: Add support for PM suspend/resume
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 8 Apr 2022 at 14:43, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Add support for suspend/resume and pm_runtime resume/suspend.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>
> Changes since v1:
> - Removed System pm calls and used force_runtime_pm calls instead
> - Added error handling at required places
> - Added pm_runtime_sync call in the sdhci_am654_remove function
> - Replaced pm_runtime_*_sync calls in probe with noidle and noresume
>   calls
> - Used MACRO SET_RUNTIME_PM_OPS to avoid build errors when CONFIG_PM
>   is disabled
>
>  drivers/mmc/host/sdhci_am654.c | 146 +++++++++++++++++++++++++++++----
>  1 file changed, 132 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e54fe24d47e7..131b2b9ae0e7 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -84,6 +84,7 @@
>  #define DRIVER_STRENGTH_40_OHM 0x4
>
>  #define CLOCK_TOO_SLOW_HZ      50000000
> +#define SDHCI_AM654_AUTOSUSPEND_DELAY  100
>
>  /* Command Queue Host Controller Interface Base address */
>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
> @@ -791,16 +792,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>
>         pltfm_host->clk = clk_xin;
>
> -       /* Clocks are enabled using pm_runtime */
> -       pm_runtime_enable(dev);
> -       ret = pm_runtime_resume_and_get(dev);
> -       if (ret)
> -               goto pm_runtime_disable;
> -
>         base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base)) {
>                 ret = PTR_ERR(base);
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>         }
>
>         sdhci_am654->base = devm_regmap_init_mmio(dev, base,
> @@ -808,31 +803,47 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>         if (IS_ERR(sdhci_am654->base)) {
>                 dev_err(dev, "Failed to initialize regmap\n");
>                 ret = PTR_ERR(sdhci_am654->base);
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>         }
>
>         ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
>         if (ret)
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
>                 dev_err(dev, "parsing dt failed (%d)\n", ret);
> -               goto pm_runtime_put;
> +               goto err_pltfm_free;
>         }
>
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
> +       pm_runtime_get_noresume(dev);
> +       ret = pm_runtime_set_active(dev);
> +       if (ret)
> +               goto pm_put;
> +       pm_runtime_enable(dev);
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret)
> +               goto pm_disable;
> +
>         ret = sdhci_am654_init(host);
>         if (ret)
> -               goto pm_runtime_put;
> +               goto clk_disable;
>
> +       /* Setting up autosuspend */
> +       pm_runtime_set_autosuspend_delay(dev, SDHCI_AM654_AUTOSUSPEND_DELAY);
> +       pm_runtime_use_autosuspend(dev);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
>         return 0;
>
> -pm_runtime_put:
> -       pm_runtime_put_sync(dev);
> -pm_runtime_disable:
> +clk_disable:
> +       clk_disable_unprepare(pltfm_host->clk);
> +pm_disable:
>         pm_runtime_disable(dev);
> +pm_put:
> +       pm_runtime_put_noidle(dev);
>  err_pltfm_free:
>         sdhci_pltfm_free(pdev);
>         return ret;
> @@ -841,23 +852,130 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  static int sdhci_am654_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         int ret;
>
> +       ret = pm_runtime_get_sync(&pdev->dev);

pm_runtime_resume_and_get() is better suited here, as it helps us to
restore the usage count in the error path.

> +       if (ret < 0)
> +               return ret;
> +
>         sdhci_remove_host(host, true);
>         ret = pm_runtime_put_sync(&pdev->dev);

We need to drop the above call to pm_runtime_put_sync(). Otherwise you
may potentially end up gating the clock, in which case the below call
to clk_disable_unprepare() becomes wrong.

>         if (ret < 0)
>                 return ret;
>
> +       clk_disable_unprepare(pltfm_host->clk);
>         pm_runtime_disable(&pdev->dev);

You need a call to pm_runtime_put_noidle() here to restore the RPM
usage count to zero.

>         sdhci_pltfm_free(pdev);
> +       return 0;
> +}

[...]

Other than the rather minor things above, this looks good to me!

Kind regards
Uffe

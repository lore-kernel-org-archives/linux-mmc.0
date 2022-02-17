Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24CFC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Feb 2022 15:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbiBQPkP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:40:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiBQPkO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 10:40:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A22B2E28
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:39:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i11so16983lfu.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RtYDADx4QQw3nzWuN70oIVG8nEMTl5DSCkcy5LhUkE=;
        b=QII7ZKn99paThcY5nBrDoRQ4DFbIageeAVtKvpe+UeTY/hcPuVE2V69G3kYeVBcjqg
         FpDph57yvjDFIAb4vvyvx/EB8NObDf6kK+pacX4hT5CuNKon/AG5ULZQHh8TY6XS9OOP
         /X4inNHe1rI//4TM0/8VKSQ/asjArtn0ltdWIIeKP1hkgFwgZ1tRMKt4PMuj5mT7F0xE
         XlDWC5MMm+kIW4DLDWm8Q9Ni9M0llxk2+dZR741HTB/51dYL2b3DHlptUyFuHrNziFUw
         vVYLS5fAEQOoLR51gNiMgqywUifJveAQmIlw1jk04xSryDjEPJz1nkSApyiNcY1KK0jk
         fQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RtYDADx4QQw3nzWuN70oIVG8nEMTl5DSCkcy5LhUkE=;
        b=vVKYb0rXvfFRXt1cFS0F9hGj7odcoBLsdv9fcI7KOwQWwuAxie/YQbmNqJvfPaGn5u
         WvO5I8a4D6+dd6N9R5h6PZEPPl6HmV3zjRrbZmt9yUWjf9QJZcd7WXHdKXBe6UkumbLL
         TtWT0zrf9Yo3COxRmc3pMycmbj8tLuhh2eqV/FsKYpQyE/rBh56Nv7GTESVRUXxqAIoM
         J8eeID8Z15sGixi7s6PuYc3unWCS78Ehtrw8bPjEuBZXJZGRjzHxwRrJUjz2mkcVJRgG
         DlDT5tiPYnOMQJVdUl1chApk6FpCBq8c2iGLwe5IhkJmG4avd4lT2Sfa5MHzEKdbqivZ
         4TfA==
X-Gm-Message-State: AOAM5304H7TYw3N/rM60lvhmQLXEWqkhkbXrfJ2PC4kEYbjcfXX7CDGj
        fqFX4uLWIOF6XdTNZsgfehhdjabJWkS3qivqk1XsEr4P0Lc=
X-Google-Smtp-Source: ABdhPJxx+WlNwrj3g8DmHHCXPTELFCPxQlK7IqCQ3NAlli3irDlMVGL1v6Gnap+Mi7IrIbGn91W64bziVKF4OQAMSk8=
X-Received: by 2002:a05:6512:3d2a:b0:443:3198:cb95 with SMTP id
 d42-20020a0565123d2a00b004433198cb95mr2461725lfv.233.1645112397989; Thu, 17
 Feb 2022 07:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20220211075056.26179-1-a-govindraju@ti.com>
In-Reply-To: <20220211075056.26179-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:21 +0100
Message-ID: <CAPDyKFpH4nnnzbFRfZ8p_vLSqh+m+fEd4yW2T2Z4rq6tRQS-Lw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Fix the driver data of AM64 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Feb 2022 at 08:51, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> The MMCSD IPs used in AM64 are the same as the ones used in J721E.
> Therefore, fix this by using the driver data from J721E for AM64 too, for
> both 8 and 4 bit instances.
>
> Fixes: 754b7f2f7d2a ("mmc: sdhci_am654: Add Support for TI's AM64 SoC")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index f654afbe8e83..b4891bb26648 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -514,26 +514,6 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>         .flags = IOMUX_PRESENT,
>  };
>
> -static const struct sdhci_pltfm_data sdhci_am64_8bit_pdata = {
> -       .ops = &sdhci_j721e_8bit_ops,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> -};
> -
> -static const struct sdhci_am654_driver_data sdhci_am64_8bit_drvdata = {
> -       .pdata = &sdhci_am64_8bit_pdata,
> -       .flags = DLL_PRESENT | DLL_CALIB,
> -};
> -
> -static const struct sdhci_pltfm_data sdhci_am64_4bit_pdata = {
> -       .ops = &sdhci_j721e_4bit_ops,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> -};
> -
> -static const struct sdhci_am654_driver_data sdhci_am64_4bit_drvdata = {
> -       .pdata = &sdhci_am64_4bit_pdata,
> -       .flags = IOMUX_PRESENT,
> -};
> -
>  static const struct soc_device_attribute sdhci_am654_devices[] = {
>         { .family = "AM65X",
>           .revision = "SR1.0",
> @@ -759,11 +739,11 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>         },
>         {
>                 .compatible = "ti,am64-sdhci-8bit",
> -               .data = &sdhci_am64_8bit_drvdata,
> +               .data = &sdhci_j721e_8bit_drvdata,
>         },
>         {
>                 .compatible = "ti,am64-sdhci-4bit",
> -               .data = &sdhci_am64_4bit_drvdata,
> +               .data = &sdhci_j721e_4bit_drvdata,
>         },
>         { /* sentinel */ }
>  };
> --
> 2.17.1
>

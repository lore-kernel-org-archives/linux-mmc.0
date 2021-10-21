Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC64C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92661604E9
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 19:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJUThI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUThI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 15:37:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D98C0613B9
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:34:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 204so1718847ljf.9
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfPdG1exyoqsagrAofCA8FWRp2LfbnD+0yi1Ma+izbU=;
        b=dQzIGiKDgjHtKcuV2a2egJjdMID/clNbQXNSqSwBosKjKw9iHwYb+jTVL3VbF82uef
         DwyKQrX20HMUA9KlrHe3l9H/JM/PCpFyiZOESfL/ku9cRA1kZ8O5KL1gk8T8qSYez7nn
         keZYSxdthbR50Dt01V3FfSmZGb0BET2nfCfwP36ZSHNAqmIIEjJa3sg6MWnWPoQ52rEB
         z979zJXlvGvneeEG/XECgq+0SlD4gFHfiDoYYxFz/f+gA5YCSne3SHJL6uwSeTXMlijv
         t3U2ZgBe3QadIXix/qcyTtB8eJqbqwtVNmUYjTazNhG1lSDwWskSdnHNyOWe9tjVcv7J
         6Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfPdG1exyoqsagrAofCA8FWRp2LfbnD+0yi1Ma+izbU=;
        b=Q8i9WUd8D3mNY4eLrvYfz5172JQ1uguhBU8WboAPRZOFarjWZ7F2H9CcGZNq/mGE6m
         8ch8WtXIV6C27wAY0Or5axiD4NGohjySr1ukMo9FpvKI5HL1e/ZhxvO3WPpuxYhishHR
         3+93UmG5aYS0286vM5X8jODWPnHW0JBNuve8Row9sCtFHQzkvmGxAun1dq5Z2B2SlIbE
         USjKCEXadUcAmcMOLAZUu/SPzvoa46cLbB+QpS17j8f0C2XxVjpkbK3uXiPsJORo+qZ6
         YCxfnVbJPq1Gak8eE+klf/1ZHmYqglAvLDZCEpZj9fq/HI3E00vqhpcGMTsMyfLJ1fdD
         2RAg==
X-Gm-Message-State: AOAM531RjARQad94f6490M66jbZZzOSNYhfgehYgaqNCeeawjtE93W2a
        K0XLSxFSqfmTYIuzI88eM2vlbiimsyY0+a0Ur9/BDA==
X-Google-Smtp-Source: ABdhPJxopEDg84hjCeiUpyIMp1whfBazBwaoTeOeOgXTY/Hsl1WxGC1nltKtZGv0ssWAlE8ibNj0WmQi8oqbCYzBj5w=
X-Received: by 2002:a2e:bd11:: with SMTP id n17mr7783336ljq.273.1634844889269;
 Thu, 21 Oct 2021 12:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211021134352.10135-1-tony@atomide.com>
In-Reply-To: <20211021134352.10135-1-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 21:34:12 +0200
Message-ID: <CAPDyKFr83Kw20272=SYUY5_r1AMmbJRb=XdGaNu0-RojuXSAXQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Fix build if CONFIG_PM_SLEEP is not set
To:     Tony Lindgren <tony@atomide.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Oct 2021 at 15:43, Tony Lindgren <tony@atomide.com> wrote:
>
> Commit f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions")
> combined the use of runtime PM and system suspend functions but left the
> ifdef CONFIG_PM_SLEEP in place causing undeclared identifier error for
> sdhci_omap_runtime_suspend if CONFIG_PM_SLEEP is not enabled.
>
> Let's fix the error by removing ifdef CONFIG_PM_SLEEP and tagging the
> reset of the PM related functions with __maybe_unused.
>
> Let's also remove the forward declaration for sdhci_omap_context_save(),
> that was accidentally left from an earlier version and is no longer used.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1210,8 +1210,6 @@ static const struct soc_device_attribute sdhci_omap_soc_devices[] = {
>         }
>  };
>
> -static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host);
> -
>  static int sdhci_omap_probe(struct platform_device *pdev)
>  {
>         int ret;
> @@ -1417,8 +1415,8 @@ static int sdhci_omap_remove(struct platform_device *pdev)
>
>         return 0;
>  }
> -#ifdef CONFIG_PM_SLEEP

This above should be:
#ifdef CONFIG_PM

sdhci_runtime_suspend|resume() host is defined like this as well, so
the below would trigger a compiler error when built with CONFIG_PM
unset.

> -static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host)
> +
> +static void __maybe_unused sdhci_omap_context_save(struct sdhci_omap_host *omap_host)
>  {
>         omap_host->con = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
>         omap_host->hctl = sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL);
> @@ -1429,7 +1427,7 @@ static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host)
>  }
>
>  /* Order matters here, HCTL must be restored in two phases */
> -static void sdhci_omap_context_restore(struct sdhci_omap_host *omap_host)
> +static void __maybe_unused sdhci_omap_context_restore(struct sdhci_omap_host *omap_host)
>  {
>         sdhci_omap_writel(omap_host, SDHCI_OMAP_HCTL, omap_host->hctl);
>         sdhci_omap_writel(omap_host, SDHCI_OMAP_CAPA, omap_host->capa);
> @@ -1471,7 +1469,6 @@ static int __maybe_unused sdhci_omap_runtime_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
>  static const struct dev_pm_ops sdhci_omap_dev_pm_ops = {
>         SET_RUNTIME_PM_OPS(sdhci_omap_runtime_suspend,

Kind regards
Uffe

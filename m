Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B35C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E3B6052B
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 15:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhJLPEy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbhJLPEx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2021 11:04:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3391C061570
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2021 08:02:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y26so89725741lfa.11
        for <linux-mmc@vger.kernel.org>; Tue, 12 Oct 2021 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eJoqAgJlqh2O2nmM1v2NiNOm7MS1e5UJQvxXAIjQYU=;
        b=yO/CCCIUXu1GwR439kw9FMl2GpN8uaq8YOHapPUnS/luUh6mY1ooc8zLO/l9BmNfIA
         Vi93nqlyWYmDxfJf7f76NA8zVn0/zM7Ja4/Kegdt2anZbjI+9dgtc6cHi9ZJK7nD7Wop
         FLNorXOIwVdrklORo9mPs4LSrFcj9Ns0vOk5nXq1YvQi6NJhlCg7bR/cY7iy/tfxndDt
         S3adSERPQbNw8Cf1xvedzswY1j3kgf0//oJPF4ZYirBIByPDu+rCbkGnaWC3Tkq0ZK+i
         5aV7q9MLI7ajx1Jr74Eir5ASemy9TYV9xjLOXGra93gJTqz8gBlRd/nBOwMWfl4dPeoR
         5p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eJoqAgJlqh2O2nmM1v2NiNOm7MS1e5UJQvxXAIjQYU=;
        b=4ICcyvGHLUaKi56NZsvX6xi33L24GdD6DxnuvN7uOOmDvnruzBH4b6rgEVcoFy2wXq
         OrJ4nDvh/lV+5gtxL3CMDz2chigW0ES7MRVJHPTDff5i5QFCXDT31G14sinDEo1lV5Jr
         gw6DWXHv9/oKLylUOdxtABENpY7ix23leYZTt2vEjMhTfTtMvyHsFVSvlbOdbkz4sqIq
         gsCayOxmLx4gKxFmW9NoZvUGwxhmUOIKsceFQsJlh1VFf4myoPwxy8qksm4IZqZDsCru
         H7Mg2qnAT0JtR65yKqxxZqaUccoR/6VeyMBShyTdWFQKpjkNN1OJcxsoPREQMbKCO/95
         eubw==
X-Gm-Message-State: AOAM532oBE/N/T5cgyLelBDNkeMzGpl3XPvXucNaSAiygXAeq3JEVbhm
        6nW9jX+nEQXe5Ka8x52hFn0ttOtQe+h2OgsdxixsoQ==
X-Google-Smtp-Source: ABdhPJybFllB0Syo/nJobMz5ywiRV9EQH+LTVA68dMR3IvZCeiDz/F+aGe9SdEaqW3Me5Yc4dHf751U3woxgC8wPzQg=
X-Received: by 2002:a05:651c:11c4:: with SMTP id z4mr21552017ljo.463.1634050970182;
 Tue, 12 Oct 2021 08:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211012103750.38328-1-tony@atomide.com> <20211012103750.38328-7-tony@atomide.com>
In-Reply-To: <20211012103750.38328-7-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Oct 2021 17:02:13 +0200
Message-ID: <CAPDyKFqXsTCTmqggiN3iDXTu=fZwCwDbFVacN=FLasQVTgFB-g@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: sdhci-omap: Configure optional wakeirq
To:     Tony Lindgren <tony@atomide.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 Oct 2021 at 12:38, Tony Lindgren <tony@atomide.com> wrote:
>
> Configure optional wakeirq. This may be optionally configured for SDIO
> dat1 pin for wake-up events for SoCs that support deeper idle states.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -12,8 +12,10 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sys_soc.h>
> @@ -117,6 +119,7 @@ struct sdhci_omap_host {
>
>         struct pinctrl          *pinctrl;
>         struct pinctrl_state    **pinctrl_state;
> +       int                     wakeirq;
>         bool                    is_tuning;
>
>         /* Offset for omap specific registers from base */
> @@ -1360,6 +1363,25 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>
>         sdhci_omap_context_save(omap_host);
>
> +       /*
> +        * SDIO devices can use the dat1 pin as a wake-up interrupt. Some
> +        * devices like wl1xxx, use an out-of-band GPIO interrupt instead.
> +        */

Ah, right I recall this now. Very clever.

> +       omap_host->wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
> +       if (omap_host->wakeirq == -EPROBE_DEFER) {
> +               ret = -EPROBE_DEFER;
> +               goto err_cleanup_host;
> +       }
> +       if (omap_host->wakeirq > 0) {
> +               device_init_wakeup(dev, true);
> +               ret = dev_pm_set_dedicated_wake_irq(dev, omap_host->wakeirq);
> +               if (ret) {
> +                       device_init_wakeup(dev, false);
> +                       goto err_cleanup_host;
> +               }
> +               host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;

To prevent the mmc core from powering off the SDIO card in system
suspend (which certainly must be prevented if wakeups should be
delivered), you need to set MMC_PM_KEEP_POWER, too.

FYI: We also have common mmc DT properties for these caps, which are
being parsed in mmc_of_parse().

These are the DT properties:
"keep-power-in-suspend" - > MMC_PM_KEEP_POWER
"wakeup-source" || "enable-sdio-wakeup" (/* legacy */) -> MMC_PM_WAKE_SDIO_IRQ;

> +       }
> +
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);
>
> @@ -1387,6 +1409,8 @@ static int sdhci_omap_remove(struct platform_device *pdev)
>
>         pm_runtime_get_sync(dev);
>         sdhci_remove_host(host, true);
> +       device_init_wakeup(dev, false);
> +       dev_pm_clear_wake_irq(dev);
>         pm_runtime_dont_use_autosuspend(dev);
>         pm_runtime_put_sync(dev);
>         /* Ensure device gets idled despite userspace sysfs config */
> --
> 2.33.0

I now think I better understand what is needed during system
suspend/resume to support system wakeups. I will comment on patch 4,
let's see what that brings us to.

Kind regards
Uffe

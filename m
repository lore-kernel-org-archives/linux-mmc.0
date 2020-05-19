Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01672C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 07:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65AB207D8
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 07:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjPMh3+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgESHvB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 03:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHvB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 03:51:01 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8653C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 00:51:00 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id w188so3113221vkf.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWUP/996Fh7GwTLcmrCS8N3g0A9uBnsZGJPQrPmtTvU=;
        b=SjPMh3+jerwOCWgGTtmfAk8U7t0SS4QOcZ1GWa+KVT2n7sElf8LW3WLG8jkA25pgeY
         JWeowZPHb5bUDCyUeTfJ1A+li8EXjJhPs42SKexQ+MS5++9nWokiHbk5gz1Ssx/oEqhR
         VTaJlGYECDJROgooM0oK0aTCCxWCwBF8GanpCeaW1R53n3+AWZv1QJfOlkvVIZXg9e5y
         Qa391fb9vnQwgFVnMqy7vCx5bITF1xrcfj1y9jr0zzMcteIKa1YFMpO8aMOmnfhebGK/
         YE69vDKubZ/iqT4LCpIhd4G0gL7LcBe9gPWWtZ5/3gmfmgMhk2cNTgE3lWo9DAGZzp2y
         qRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWUP/996Fh7GwTLcmrCS8N3g0A9uBnsZGJPQrPmtTvU=;
        b=IKqeQVUP2ziuHjps0ehAKptZxuX7CzO507B6efOwte2OgNgKTzVdYJhNsFPixB8ymC
         sHKYUtmi7K3cYYeSwciUcykEfHBjLijlEXUfZbZXN6x5SDuzxYh4AsJZuqU0BBhV/nOV
         /kmlUkhYdxOOCwYkOLdymV7fGuY8EE/A3qPjWlNIEhv/UIFC1ZJSQXNeG6vkZR2ykL78
         eSvWXoPUlSzX/gNATnWgLKvEGGeo96fIXSm3UW/nrVUvXFMcFqEIyShVuoDWgfqbLHrQ
         rrrcTgBKkZUwA/JN3cYRVgpeYU6SYiR/APGpIP5vH/chd7UW4rXMCW/PD0i0QSp86kyl
         5fRg==
X-Gm-Message-State: AOAM530zyGs8ELyTVgOzIE5GMH5U/umsyO5AP5sEzOpZu07UhqP/Lbd7
        R8Q59IfCVJybs5XwqDD29MtXpWrkA5D68Lbfq68MUA==
X-Google-Smtp-Source: ABdhPJyXsoNq0wngwZ2Wtcqk6vGGf9jqnltktVtSlavHpCe6CSGwTgLNoQ0IFCY3DTpWyQUGYI0Ml5m8yS/oQfzNZW0=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr13812463vkl.53.1589874659867;
 Tue, 19 May 2020 00:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org> <20200518202200.GC5109@ninjato>
In-Reply-To: <20200518202200.GC5109@ninjato>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 May 2020 09:50:23 +0200
Message-ID: <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 May 2020 at 22:22, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Fri, May 15, 2020 at 04:04:59PM +0200, Ulf Hansson wrote:
> > If the tmio device is attached to a genpd (PM domain), that genpd may have
> > ->start|stop() callback assigned to it. To make sure the device is
> > accessible during ->probe(), genpd's ->start() callback must be invoked,
> > which is currently managed by tmio_mmc_host_probe(). This is very likely to
> > be too late for some cases, as registers may be read and written way before
> > that.
> >
> > To fix this behaviour, let's drop the call to dev_pm_domain_start() from
> > tmio_mmc_host_probe() - and let the tmio clients manage this instead.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Okay, this seems to work on Gen3.

Great, thanks!

>
> > @@ -909,6 +910,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
> >       if (ret)
> >               goto efree;
> >
> > +     dev_pm_domain_start(&pdev->dev);
> > +
>
> Can't we put it before the custom clk_enable()? And then clean up
> further like this to have the main clock only controlled via RPM?

I understand what you want to achieve, but to allow that to work we
need to consider the below things first.

1. If the driver is built with CONFIG_PM unset, then runtime PM
doesn't work and hence the clock won't be managed by a PM domain.
2. If there is a platform configuration where a PM domain (genpd)
isn't going to be attached, then the clock needs to be managed locally
in the driver.

>
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -83,16 +83,11 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
>  {
>         struct mmc_host *mmc = host->mmc;
>         struct renesas_sdhi *priv = host_to_priv(host);
> -       int ret = clk_prepare_enable(priv->clk);
> -
> -       if (ret < 0)
> -               return ret;
> +       int ret;
>
>         ret = clk_prepare_enable(priv->clk_cd);
> -       if (ret < 0) {
> -               clk_disable_unprepare(priv->clk);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         /*
>          * The clock driver may not know what maximum frequency
> @@ -198,7 +193,6 @@ static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
>  {
>         struct renesas_sdhi *priv = host_to_priv(host);
>
> -       clk_disable_unprepare(priv->clk);
>         clk_disable_unprepare(priv->clk_cd);
>  }
>
> @@ -906,12 +900,12 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         /* All SDHI have SDIO status bits which must be 1 */
>         mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
>
> +       dev_pm_domain_start(&pdev->dev);
> +
>         ret = renesas_sdhi_clk_enable(host);
>         if (ret)
>                 goto efree;
>
> -       dev_pm_domain_start(&pdev->dev);
> -
>         ver = sd_ctrl_read16(host, CTL_VERSION);
>         /* GEN2_SDR104 is first known SDHI to use 32bit block count */
>         if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)
>
>
> Again, this is only tested on Gen3. I will check Gen2 tomorrow.
>
> > diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> > index 93e83ad25976..b8f5687e10be 100644
> > --- a/drivers/mmc/host/tmio_mmc.c
> > +++ b/drivers/mmc/host/tmio_mmc.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/mmc/host.h>
> >  #include <linux/module.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/scatterlist.h>
> >
> >  #include "tmio_mmc.h"
> > @@ -172,6 +173,8 @@ static int tmio_mmc_probe(struct platform_device *pdev)
> >       host->mmc->f_max = pdata->hclk;
> >       host->mmc->f_min = pdata->hclk / 512;
> >
> > +     dev_pm_domain_start(&pdev->dev);
> > +
>
> I am quite sure tmio_mmc won't need this, but better safe than sorry.

Okay!

I observed that tmio_mmc doesn't manage external clocks and don't have
->clk_enable|disable() callbacks, but using runtime PM.

That made me think that perhaps the clocks were managed through the PM domain.

Kind regards
Uffe

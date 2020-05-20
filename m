Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D85C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 15:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BDF20671
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 15:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgETP5M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 11:57:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36903 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgETP5M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 11:57:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id x22so2875209otq.4
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 08:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIhoM8K69c4r2tFZMVJP+9PUs7wXphJgxXZ3sX1Z8DM=;
        b=GpXABSwSUlHmwaikmQdEYNw4gINlFMITyZEU6a/A3UBmBdfxTE7ahwC+NIiQtTEBcb
         wgfyNEGdEH03ePzkoIPjG60WSiNrpHvQTHIwGQx2Nb5e5NS/mLrric6yIgOGDM7Qv1Lc
         01HKPhtg4gF3W084RIb/XKVbsdB/Z3tXpwDsX/JjT0wO2hTbHOGEUQQsJNrGAS6bRmC2
         oFMxvc9vLKOvqHZA/WU8cmF0zBZUgmk8esjRZ+ZDxo6TRFV6TAss7yMWmu5EcCaIZeiQ
         A9tVcq49xhwSH39IpPqQSV9F9y+22v6KrBfcjLQZoSrFWHbZwBDUHjFTTIsb6+nRO32G
         rCCg==
X-Gm-Message-State: AOAM532ISzZbUsN7z5NvQ+Xd5FD8ybCDJVWAZGf0ksUb+kCBmn1RrwNS
        81qFsv917+E8VRBxKrUIocGq7MsvEK8xcAgaeYk=
X-Google-Smtp-Source: ABdhPJz4qVBN68NI9JI2yAbVzc0ESRJWlEQwoEW6QBEw1scrS1B4lMOscVhgRv/HL9l3mVLHeq3oRZ9UTALzc3WEzvs=
X-Received: by 2002:a9d:564:: with SMTP id 91mr3709928otw.250.1589990231461;
 Wed, 20 May 2020 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152445.6922-1-ulf.hansson@linaro.org>
In-Reply-To: <20200519152445.6922-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 May 2020 17:57:00 +0200
Message-ID: <CAMuHMdXc8jzLoKbb_heX-Ftb+3RNOQRtEX=7NS4KxWdxUfBcwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> If the tmio device is attached to a genpd (PM domain), that genpd may have
> ->start|stop() callback assigned to it. To make sure the device is
> accessible during ->probe(), genpd's ->start() callback must be invoked,
> which is currently managed by tmio_mmc_host_probe(). However, it's likely
> that may be too late for some cases, as registers may be read and written
> way before that point.
>
> To fix the behaviour, let's move the call to dev_pm_domain_start() from
> tmio_mmc_host_probe() into those clients that needs it. From discussions at
> linux-mmc mailing list, it turned out that it should be sufficient to do
> this for the SDHI renesas variants, hence the call is move to
> renesas_sdhi_probe().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 3 +++
>  drivers/mmc/host/tmio_mmc_core.c     | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index ff72b381a6b3..dcba9ad35dd1 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/mfd/tmio.h>
> @@ -905,6 +906,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         /* All SDHI have SDIO status bits which must be 1 */
>         mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
>
> +       dev_pm_domain_start(&pdev->dev);
> +


I have debug prints at the top of genpd_stop_dev():

    pr_info("==== %s/%s: stop\n", genpd->name, dev_name(dev));

and genpd_start_dev():

    pr_info("==== %s/%s: start\n", genpd->name, dev_name(dev));

On Koelsch (R-Car M2-W), the three SDHI devices are started twice:

    PM: ==== always-on/ee100000.sd: start
    PM: ==== always-on/ee140000.sd: start
    PM: ==== always-on/ee160000.sd: start
    PM: ==== always-on/ee100000.sd: start
    PM: ==== always-on/ee140000.sd: start
    PM: ==== always-on/ee160000.sd: start

The first time, the probe is deferred, because the regulator needed in
tmio_mmc_init_ocr() hasn't been instantiated yet. The SDHI device is
detached from the PM domain, but not stopped.
Interestingly, I see no clock imbalances afterwards.

On R-Car Gen3, R-Mobile A1, and RZ/A systems, they are started once,
as expected.

On R-Mobile APE6 and SH-Mobile AG5, one device is stopped and started
again:

    PM: ==== a3sp/ee100000.sd: start
    PM: ==== a3sp/ee120000.sd: start
    PM: ==== a3sp/ee120000.sd: stop
    PM: ==== a3sp/ee120000.sd: start

But here no probe deferral is involved.
Just Runtime PM kicking in, I guess.

>         ret = renesas_sdhi_clk_enable(host);
>         if (ret)
>                 goto efree;
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index ba301fb7656b..d7fde57c78c1 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -39,7 +39,6 @@
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> @@ -1192,7 +1191,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         /* See if we also get DMA */
>         tmio_mmc_request_dma(_host, pdata);
>
> -       dev_pm_domain_start(&pdev->dev);

Before, the issue on probe deferral didn't happen, as the device was only
started after the regulator was found.

>         pm_runtime_get_noresume(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

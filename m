Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7FC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 16:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C7420671
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 16:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X25mO4FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETQM2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETQM2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 12:12:28 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CEFC061A0E
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 09:12:27 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u2so2109897vsi.13
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtrzLXGtxgRWkzlUqxtu97QqoZy64rwr9++B/m+w0bM=;
        b=X25mO4FMVFWX9bD4sVjVdh6jjataSoBgWwqq7lzOARIYBhnm3zLBKkY9JTZx8EgSAq
         7aNz2eLhfh/m6xOFl/fobLsZ13/d6V+wop2isk9rpCP8RcOuf4jdok4ulS0GcLLQZUEo
         C1lcgXy8FoEivSrEG/HgFDWOBZMcFP6W5NVZTCxhgANHntp1XotjhrIrY2P7nfrzF4fN
         LwOgsH8MJnBlq04yRlUbgjwD4xZYwek9WGtbq1xSh9QR0L39c0XpsJrK6rMCxW2a3a2h
         7RtUli0zxYZuQs687PvV6H5aqXpzoWGfHHzu8h7dsB/f0Ef+DRb1Gsj1MtMRt8cflgVU
         4G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtrzLXGtxgRWkzlUqxtu97QqoZy64rwr9++B/m+w0bM=;
        b=ct81haVUIidy+yjOTxTb7lhatQRFQS8IcTBqGqmDePEkxMT9kqH8SFv61qVIyvIqnj
         7pWwGhp4DkKij1VhixJiR8dWasjY60KVPXJGeflD1EPtcFJHjPsUwY1bGBJpTK0oMoDi
         wuIM4H2TfKimSFn6nJ99rI4l17ajEJpKfe1ZZnlu/1asDgYVJTzBt37d6URdOPsEDdwv
         DSnGFuyB8pav+xcQPHCJ3xzc9Qjk8lX2gB6od48NiPbLYnTUDZmaZua6EE9AfzY+V9AV
         uf8UVnJEyMh54hSZZwPigRX0HpDI+LD6cVcQus5EugjTxm9r+OGz/rO1YUAzDG1ttBeK
         19HQ==
X-Gm-Message-State: AOAM531R557oIb3bNwqkUpPHSy1R/LkEwTRZ/5O/ruFOEa6D1pa8i+OM
        Y8TLD+em75fPuDCmdamKd+GlM/9U/INnzP8op+H4bg==
X-Google-Smtp-Source: ABdhPJyUxYSmAfttYuzTfbgRH+uY3/B82jtNFyWpV0GDSdLZj6mIIT72znl6jOaKVWRHsC01UabEC6lC4aZ+E7zxU9U=
X-Received: by 2002:a05:6102:5d6:: with SMTP id v22mr3741710vsf.191.1589991146916;
 Wed, 20 May 2020 09:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152445.6922-1-ulf.hansson@linaro.org> <CAMuHMdXc8jzLoKbb_heX-Ftb+3RNOQRtEX=7NS4KxWdxUfBcwA@mail.gmail.com>
In-Reply-To: <CAMuHMdXc8jzLoKbb_heX-Ftb+3RNOQRtEX=7NS4KxWdxUfBcwA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 18:11:50 +0200
Message-ID: <CAPDyKFpBo3T-RhszJq8wL_wTzsVmo9zz=Ng6G=2R=Jx2XyrdFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Wed, 20 May 2020 at 17:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > If the tmio device is attached to a genpd (PM domain), that genpd may have
> > ->start|stop() callback assigned to it. To make sure the device is
> > accessible during ->probe(), genpd's ->start() callback must be invoked,
> > which is currently managed by tmio_mmc_host_probe(). However, it's likely
> > that may be too late for some cases, as registers may be read and written
> > way before that point.
> >
> > To fix the behaviour, let's move the call to dev_pm_domain_start() from
> > tmio_mmc_host_probe() into those clients that needs it. From discussions at
> > linux-mmc mailing list, it turned out that it should be sufficient to do
> > this for the SDHI renesas variants, hence the call is move to
> > renesas_sdhi_probe().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/host/renesas_sdhi_core.c | 3 +++
> >  drivers/mmc/host/tmio_mmc_core.c     | 2 --
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> > index ff72b381a6b3..dcba9ad35dd1 100644
> > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/slot-gpio.h>
> >  #include <linux/mfd/tmio.h>
> > @@ -905,6 +906,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
> >         /* All SDHI have SDIO status bits which must be 1 */
> >         mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
> >
> > +       dev_pm_domain_start(&pdev->dev);
> > +
>
>
> I have debug prints at the top of genpd_stop_dev():
>
>     pr_info("==== %s/%s: stop\n", genpd->name, dev_name(dev));
>
> and genpd_start_dev():
>
>     pr_info("==== %s/%s: start\n", genpd->name, dev_name(dev));
>
> On Koelsch (R-Car M2-W), the three SDHI devices are started twice:
>
>     PM: ==== always-on/ee100000.sd: start
>     PM: ==== always-on/ee140000.sd: start
>     PM: ==== always-on/ee160000.sd: start
>     PM: ==== always-on/ee100000.sd: start
>     PM: ==== always-on/ee140000.sd: start
>     PM: ==== always-on/ee160000.sd: start
>
> The first time, the probe is deferred, because the regulator needed in
> tmio_mmc_init_ocr() hasn't been instantiated yet. The SDHI device is
> detached from the PM domain, but not stopped.
> Interestingly, I see no clock imbalances afterwards.

That's because genpd's->detach_dev() callback is invoked at the
"deferred probe" case. In your case this ends up calling
pm_clk_destroy(). Thus the clock gets disabled and unprepared
correctly.

>
> On R-Car Gen3, R-Mobile A1, and RZ/A systems, they are started once,
> as expected.
>
> On R-Mobile APE6 and SH-Mobile AG5, one device is stopped and started
> again:
>
>     PM: ==== a3sp/ee100000.sd: start
>     PM: ==== a3sp/ee120000.sd: start
>     PM: ==== a3sp/ee120000.sd: stop
>     PM: ==== a3sp/ee120000.sd: start
>
> But here no probe deferral is involved.
> Just Runtime PM kicking in, I guess.

Yep, and that's okay, right?

>
> >         ret = renesas_sdhi_clk_enable(host);
> >         if (ret)
> >                 goto efree;
> > diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> > index ba301fb7656b..d7fde57c78c1 100644
> > --- a/drivers/mmc/host/tmio_mmc_core.c
> > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > @@ -39,7 +39,6 @@
> >  #include <linux/module.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/pm_domain.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> > @@ -1192,7 +1191,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
> >         /* See if we also get DMA */
> >         tmio_mmc_request_dma(_host, pdata);
> >
> > -       dev_pm_domain_start(&pdev->dev);
>
> Before, the issue on probe deferral didn't happen, as the device was only
> started after the regulator was found.

I am not sure there is an issue or did I miss something?

>
> >         pm_runtime_get_noresume(&pdev->dev);
> >         pm_runtime_set_active(&pdev->dev);
> >         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>
> Gr{oetje,eeting}s,
>
>                         Geert

Thanks a lot for testing and sharing results! Very much appreciated!

Kind regards
Uffe

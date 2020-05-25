Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B0FC433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC97207FB
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5ftEkP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbgEYIsN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389105AbgEYIsN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 04:48:13 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB5C061A0E
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u79so9548748vsu.4
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=puNhZacJT8QWYo+JNLLTVwim9VBabQB0T57Qsi+CyVY=;
        b=K5ftEkP2XpAxH1h1WN38uFuoZJ5YbioMXdDB1CtW7iPwtVrKcdS7bZBALbF5XGxxP6
         yxdM5p1Q39pBejOFgLXl4qxsDG7lK6ILAugytNQGjId36qlSvu0GDbj29+zMgr2G6y86
         Ji+X+awr/L4YPRIBzVB5Pj5ExkkWoScvpAJC8LQaezNVMgbGo03PW3l9tNwHYIy0izSg
         He/4A2dzOnj2puVLq/DLxwDJ8h8uakZEzAMH7BayQWPVd860hqcWpeBEBYUOyUPrWj4j
         Lp5KYN+ScIeLgWm2/nwnF87qPUfUVEt+63WrpT7yuD2CJZfPJfwBf4rd5FLARxk/aRpS
         zUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puNhZacJT8QWYo+JNLLTVwim9VBabQB0T57Qsi+CyVY=;
        b=FVg9K0VOm2BL+ZtRH2juezhwQZaWj2q/+JlobCBkoRGRdVvQuRuPOAAmtfGlkmpv+F
         gfdRYzjnDKeZTZpMTVGx3yRy1tgb9DdvCJUVnkRwv+RTdSoKrytO03h4MNa3gWVD1Bux
         lOY4gxcb1TAAYl/j5RZOe1RAYf/0CIS/Q2JPDEct/V+e+id6/tjDX3YJ8156db18kB8X
         nrQ4CUY7Q4PebmOiZiG/t7i/c7IRMN1eEaNYapdac1HE4GfPoCczwsG4vzwdA+Y5K57/
         N+7dEPkuxs14LDDN/TB++8DiekYgXzwM2av34h9ZWfjrcka7viKdxrMOSFPVvcQuD/BM
         JJGw==
X-Gm-Message-State: AOAM533ObP5GcyYF1Ug3/Kl4+xwU6So91jSyW/Mr8WWdqrp8z7t7Qf1T
        PmegJSvoPMW/5kb0BabASoCmy8GN3Og6yFm5Mwlt3R9Bjaw=
X-Google-Smtp-Source: ABdhPJx3iR0vS3Dd7VlAKowTP5gyCfXOAOsZApPDeaRGz4WfSuBYacf1BiYTOpREGZDMvQ2ku/wHpDhB4bBpYXMOS0g=
X-Received: by 2002:a67:ec58:: with SMTP id z24mr14891674vso.200.1590396491825;
 Mon, 25 May 2020 01:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152445.6922-1-ulf.hansson@linaro.org> <CAMuHMdXc8jzLoKbb_heX-Ftb+3RNOQRtEX=7NS4KxWdxUfBcwA@mail.gmail.com>
 <CAPDyKFpBo3T-RhszJq8wL_wTzsVmo9zz=Ng6G=2R=Jx2XyrdFQ@mail.gmail.com> <CAMuHMdWX8PrKA-VNFPAegAxE5vb_xDEnqSoytksfxPSuYaiv2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWX8PrKA-VNFPAegAxE5vb_xDEnqSoytksfxPSuYaiv2Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 10:47:34 +0200
Message-ID: <CAPDyKFrzY67it3UbDDTCe-z95_sKO5EQaiGm=6NbmPDJ8fFqcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 May 2020 at 19:42, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Wed, May 20, 2020 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 20 May 2020 at 17:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > If the tmio device is attached to a genpd (PM domain), that genpd may have
> > > > ->start|stop() callback assigned to it. To make sure the device is
> > > > accessible during ->probe(), genpd's ->start() callback must be invoked,
> > > > which is currently managed by tmio_mmc_host_probe(). However, it's likely
> > > > that may be too late for some cases, as registers may be read and written
> > > > way before that point.
> > > >
> > > > To fix the behaviour, let's move the call to dev_pm_domain_start() from
> > > > tmio_mmc_host_probe() into those clients that needs it. From discussions at
> > > > linux-mmc mailing list, it turned out that it should be sufficient to do
> > > > this for the SDHI renesas variants, hence the call is move to
> > > > renesas_sdhi_probe().
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/mmc/host/renesas_sdhi_core.c | 3 +++
> > > >  drivers/mmc/host/tmio_mmc_core.c     | 2 --
> > > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> > > > index ff72b381a6b3..dcba9ad35dd1 100644
> > > > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > > > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > > > @@ -24,6 +24,7 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/pm_domain.h>
> > > >  #include <linux/mmc/host.h>
> > > >  #include <linux/mmc/slot-gpio.h>
> > > >  #include <linux/mfd/tmio.h>
> > > > @@ -905,6 +906,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
> > > >         /* All SDHI have SDIO status bits which must be 1 */
> > > >         mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
> > > >
> > > > +       dev_pm_domain_start(&pdev->dev);
> > > > +
> > >
> > >
> > > I have debug prints at the top of genpd_stop_dev():
> > >
> > >     pr_info("==== %s/%s: stop\n", genpd->name, dev_name(dev));
> > >
> > > and genpd_start_dev():
> > >
> > >     pr_info("==== %s/%s: start\n", genpd->name, dev_name(dev));
> > >
> > > On Koelsch (R-Car M2-W), the three SDHI devices are started twice:
> > >
> > >     PM: ==== always-on/ee100000.sd: start
> > >     PM: ==== always-on/ee140000.sd: start
> > >     PM: ==== always-on/ee160000.sd: start
> > >     PM: ==== always-on/ee100000.sd: start
> > >     PM: ==== always-on/ee140000.sd: start
> > >     PM: ==== always-on/ee160000.sd: start
> > >
> > > The first time, the probe is deferred, because the regulator needed in
> > > tmio_mmc_init_ocr() hasn't been instantiated yet. The SDHI device is
> > > detached from the PM domain, but not stopped.
> > > Interestingly, I see no clock imbalances afterwards.
> >
> > That's because genpd's->detach_dev() callback is invoked at the
> > "deferred probe" case. In your case this ends up calling
> > pm_clk_destroy(). Thus the clock gets disabled and unprepared
> > correctly.
>
> Indeed, I had just arrived at the same conclusion.
> While genpd doesn't have reference counting on start/stop, pm_clk does
> have pce_status to track state, so when needed, __pm_clk_remove()
> disables the clock before its destruction.
>
> > > On R-Car Gen3, R-Mobile A1, and RZ/A systems, they are started once,
> > > as expected.
> > >
> > > On R-Mobile APE6 and SH-Mobile AG5, one device is stopped and started
> > > again:
> > >
> > >     PM: ==== a3sp/ee100000.sd: start
> > >     PM: ==== a3sp/ee120000.sd: start
> > >     PM: ==== a3sp/ee120000.sd: stop
> > >     PM: ==== a3sp/ee120000.sd: start
> > >
> > > But here no probe deferral is involved.
> > > Just Runtime PM kicking in, I guess.
> >
> > Yep, and that's okay, right?
>
> Correct.
>
> > > > @@ -1192,7 +1191,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
> > > >         /* See if we also get DMA */
> > > >         tmio_mmc_request_dma(_host, pdata);
> > > >
> > > > -       dev_pm_domain_start(&pdev->dev);
> > >
> > > Before, the issue on probe deferral didn't happen, as the device was only
> > > started after the regulator was found.
> >
> > I am not sure there is an issue or did I miss something?
>
> No, it's just a bit strange to see an imbalance in start/stop.
>
> Note that this does mean that all PM domain providers that do not rely
> on pm_clk, but have their own start/stop methods, need to be aware of
> this quirk, and should take care of reference counting themselves.
> Fortunately there seems to be only one:
> drivers/soc/ti/ti_sci_pm_domains.c.
> Unfortunately it doesn't do reference counting, so if that PM domain
> driver is ever used with a driver that calls dev_pm_domain_start(),
> mysterious things may happen...

Good point. Perhaps we should document this somewhere.

>
> > Thanks a lot for testing and sharing results! Very much appreciated!
>
> So I guess I can provide my
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> for this one, too, finally.

Great, thanks! I have added your tag for the other renesas sdhi patch as well.

Kind regards
Uffe

Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1358C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFCE207E8
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgESI3S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 04:29:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38508 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgESI3S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 04:29:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id w22so10477102otp.5
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 01:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1QZ+glnLGTLhzLtAl7vyU0/fzAmoLRE/3Xmr8fiwe4=;
        b=k2bzffKWirWfa5ihOAUbfNNvPdxuSx1sJ8eyGFFqE5BBBsrGGUhqtC5xpQxLwmyCpf
         4Fye+TM7pvY80fYKGzNaWLhnfS+DMTiJ9KY4bu+MxOxyjnEChH5SPedgpXocu2AR+6aU
         33tZ5dlF/2rYhP7ALVE5oDdE75wfa/6Du/ql8ME0f2l2Qp9BXIa/4gryNdhBTNavZmyQ
         CJ6z4R3hDqgyitLje4eGp4ZIQGQHBZ0qJdd031Rx1NMlCyJewH7LVnSBMtUP8HSElGnh
         8L+xNWXSHRzXZ6Dcuq1hti1iOdoxY8/u/j7G0tuQRKGwRG2d+NHBMPiJIj59ofMWtJtE
         SA8A==
X-Gm-Message-State: AOAM533QiMkARVPLyvrGkmOsR2G0ql4o6gKb0cosaue5OCW+l1ZKrMzt
        mspF4Oj3W0kReXS6pANd3EMLyAet/sqnDN5gpyw=
X-Google-Smtp-Source: ABdhPJy58j7mkhPeFbRhKQoxocZnpEGsXAu1pe/5xPiAedgUrYGa0HlvsMqAHhiwqKoWq34SPw6xM4poHIKp3dk+OWc=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr11069797ote.107.1589876957618;
 Tue, 19 May 2020 01:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <CAMuHMdWscejrUbfx0-C=WFC6-vECA9HTkKs0=osWGUPBY6yPxA@mail.gmail.com> <CAPDyKFrTfVAj4WbpdAvOxW_rKej=BxTqu8nn1_K985=cHacpXw@mail.gmail.com>
In-Reply-To: <CAPDyKFrTfVAj4WbpdAvOxW_rKej=BxTqu8nn1_K985=cHacpXw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 May 2020 10:29:05 +0200
Message-ID: <CAMuHMdWe0A=5Maj08evA4Dqp3bnddiKiMgVZF+PHGoe8VP6ZkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi Ulf,

On Tue, May 19, 2020 at 10:19 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 18 May 2020 at 23:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, May 15, 2020 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > If the tmio device is attached to a genpd (PM domain), that genpd may have
> > > ->start|stop() callback assigned to it. To make sure the device is
> > > accessible during ->probe(), genpd's ->start() callback must be invoked,
> > > which is currently managed by tmio_mmc_host_probe(). This is very likely to
> > > be too late for some cases, as registers may be read and written way before
> > > that.
> > >
> > > To fix this behaviour, let's drop the call to dev_pm_domain_start() from
> > > tmio_mmc_host_probe() - and let the tmio clients manage this instead.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > So this moves the call to dev_pm_domain_start(). No new calls are added.
> > If I get it right, dev_pm_domain_start() just calls into
> > genpd_dev_pm_start() through a function pointer, and starts the device
> > through the system-specific PM Domain handler.  On R-Car SoCs, that
> > is pm_clk_resume(), i.e. enabling the module clock through the clock
> > domain.
>
> Correct.
>
> > I have two questions there:
> >   1. What if the device is already started?
> >      There seems to be no reference counting involved.
>
> The device can't be started as runtime PM hasn't been enabled yet for
> the device - and this is controlled by the tmio/renesas driver.

OK.

> >   2. Who stops the device again?
>
> Beyond this point there are two main cases to consider.
>
> 1. The driver is probed successfully and thus up and running. Then,
> when the device becomes runtime suspended (because of request
> inactivity, for example), the device will be "stopped" through genpd.

OK.

> 2. The driver failed to probe or the ->remove() callback is invoked
> for the device. This will trigger the platform bus to call
> dev_pm_domain_detach(). In this path, genpd invokes the
> genpd->detach_dev() callback for the device, which allows the genpd
> provider to deal with the clean up. In this particular case, I assume
> pm_clk_destroy() is going to be called for the device.

OK.

> > I always thought the PM Domain was powered on (if still off), and the
> > device started, by calling pm_runtime_get_sync().
>
> Correct.
>
> However, deploying that kind of pattern in a driver can be a bit
> messy, while considering that CONFIG_PM may be set or unset and the
> driver should work in both configurations. In principle, it leads to
> boilerplate code in drivers, especially if the driver has runtime PM
> callbacks assigned to it as shown in commit 1b32999e205b ("mmc: tmio:
> Avoid boilerplate code in ->runtime_suspend()").
>
> Does it make sense?

Now it does, thanks!

Note that for devices handled by renesas_sdhi, CONFIG_PM is always
set (cfr. drivers/soc/renesas/Kconfig), and there will always by a genpd.
So the "messy" part matters for TMIO and UniPhier only.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

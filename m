Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B456CC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898FA2072C
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 18:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETSUE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 14:20:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39943 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETSUD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 14:20:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id v128so3794993oia.7
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 11:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOXiImpGNYC7qwcBahwxE4WcJzR1ntKPHJ2shA3YPaM=;
        b=kry6Lj6b0f5iFU8V7vIBNph+3c2hv6TBP8HRW8NH+bW29Z6/E9m2//nbfB/gPcTXkG
         /2/hZTDNpdZIhso3+6JHqLYxl1W0Plxd5QfVTtxxmQeMF75P4OpFV7z1ddJfMpER5EW/
         i+dtkQT6ZSlr3kNqOmiuWiLo1rf073SbtMGigTalJSy6K4kEqKR3mWcHI5D1x65NTlul
         gCUjqORsf3l9eR7yEfws4HhJI4pm2sjqKlAGXlXILJE5jhoFj2uZlSlZ9GtCHOubAMPH
         Jt41TxIQeF0Q6MQPCYkPlycNNpTigu7T/ySFUSf3B0LULMFdwAv02Hk+dg+U9RG73PuD
         2tNA==
X-Gm-Message-State: AOAM532YtTQPkxLMlCDnJ+BDdM79+bG2ZpKQshaZlGf8+MhMKJAJKSH3
        f6QrL62Mv/94oPpwhs288Qfh3PC+GzqSaTQik4k=
X-Google-Smtp-Source: ABdhPJyFbOYrRUpot3VS+qeQ43Rhsfx3e6t9o8fNGszgVvSmqp5zKOQM1unQWC41xf2pvCCZUOpk4gmaVlkJo6DmM5c=
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr4149331oic.54.1589998802545;
 Wed, 20 May 2020 11:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152434.6867-1-ulf.hansson@linaro.org> <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
 <20200520154906.GE5759@ninjato>
In-Reply-To: <20200520154906.GE5759@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 May 2020 20:19:50 +0200
Message-ID: <CAMuHMdU99uc8fUO7gPVh1K-ZwqgpqfvFB7fVckrKzC8N-8wa8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at remove
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

On Wed, May 20, 2020 at 5:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> On Wed, May 20, 2020 at 04:30:33PM +0200, Geert Uytterhoeven wrote:
> > On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > Before calling tmio_mmc_host_probe(), the caller is required to enable
> > > clocks for its device, as to make it accessible when reading/writing
> > > registers during probe.
> > >
> > > Therefore, the responsibility to disable these clocks, in the error path of
> > > ->probe() and during ->remove(), is better managed outside
> > > tmio_mmc_host_remove(). As a matter of fact, callers of
> > > tmio_mmc_host_remove() already expects this to be the behaviour.
> > >
> > > However, there's a problem with tmio_mmc_host_remove() when the Kconfig
> > > option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
> > > disable the clock via runtime PM, which leads to clock enable/disable
> > > imbalance problems, when the caller of tmio_mmc_host_remove() also tries to
> > > disable the same clocks.
> > >
> > > To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
> > > device with clocks enabled, but also make sure to disable the IRQs, as we
> > > normally do at ->runtime_suspend().
> > >
> > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > (on R-Car Gen2, various Gen3, SH-Mobile AG5, R-Mobile A1, R-Mobile APE6,
> >  RZ/A1, and RZ/A2)
>
> Thanks, Geert! If it is not too much to ask, could you try re-applying
> commit 7a7dab237027 ("mmc: tmio: remove workaround for NON_REMOVABLE")
> on top of all these patches and see if your NFS is still stalled?
>
> Sidenote: we still need to tackle the problem when SCC hangs because it
> has no clock. However, I am still interested if all the PM updates have
> an impact in the beaviour you observed here[1].
>
> [1] https://patchwork.kernel.org/patch/11149285/

I reverted "[PATCH] WIP: clk: renesas: rcar-gen3: enable SDnH clk for HS
modes" (which I still had applied in my local tree), and reapplied "mmc:
tmio: remove workaround for NON_REMOVABLE", but I cannot reproduce the
issue, with or without the top 3 commits on mmc/next:
ff5a1a63febb0761 mmc: tmio: Further fixup runtime PM management at remove
774c44ceff3c5b3f mmc: tmio: Make sure the PM domain is 'started' while probing
4863bb62a87786ec mmc: renesas_sdhi: remove manual clk handling

Let's see if I can bisect where it was fixed...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

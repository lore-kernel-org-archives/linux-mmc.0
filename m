Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2164C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2CD207D4
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 19:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETTaA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 15:30:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39297 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETT37 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 15:29:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id d7so3497415ote.6
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 12:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vv0OjxPegLQndqk2ITHvZ/9lxZSEd0kqbk5s9DZy22o=;
        b=Pboc21UXPDBAPMViXzfNtIx0/uMsXCpF3AxUyBV3mUs2LDw8dALnRjEMdFxPvNxlXm
         6jf5bvJaLHvCPkCv4x9dIIlvUzT8/NdngnF9jXz/U56aIEq1U1gexmrlx4oocVXcbNT5
         H8wMDjIOrwsU5pUgVd5r9cKwvd4bxec/tsR7HhvegGA3fE42cETprHD+khb+4h3vb9oR
         ybrQdBmHjeM8y33nye8n/RuhbUiY818h26xu6I+HabQzVQKJulqognp/dKtUa9NvA6IK
         zK0/Tbh1fmuNo6ZbcSZWfoHacF0YJUmn0Zn6YOoMcIPO+GqrPSSPWOoWGlcNRMDFdXO/
         Kx4A==
X-Gm-Message-State: AOAM532tKHxe5eZWy7Jf6liGuCjTSvoEQq8573JQidwWfQffMpe4dPMW
        bo/gJxy4yqPVgWDca+4QVEB5vvjPJqWj9qL9k7w=
X-Google-Smtp-Source: ABdhPJyleUsdaBj+r+MXCPRqIZ106M3H81cUpa/Jyt7wKiqDcdKbfsaj26aRtWAIo/AROXfRFSH9Z7Jnl323EOl3VKg=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr4305823otp.145.1590002997255;
 Wed, 20 May 2020 12:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152434.6867-1-ulf.hansson@linaro.org> <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
 <20200520154906.GE5759@ninjato> <CAMuHMdU99uc8fUO7gPVh1K-ZwqgpqfvFB7fVckrKzC8N-8wa8A@mail.gmail.com>
In-Reply-To: <CAMuHMdU99uc8fUO7gPVh1K-ZwqgpqfvFB7fVckrKzC8N-8wa8A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 May 2020 21:29:45 +0200
Message-ID: <CAMuHMdUdT7MJkArMNcuX-uaryqR3qALfJSDJapBaXy8F6isffQ@mail.gmail.com>
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

On Wed, May 20, 2020 at 8:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, May 20, 2020 at 5:49 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > On Wed, May 20, 2020 at 04:30:33PM +0200, Geert Uytterhoeven wrote:
> > > On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > Before calling tmio_mmc_host_probe(), the caller is required to enable
> > > > clocks for its device, as to make it accessible when reading/writing
> > > > registers during probe.
> > > >
> > > > Therefore, the responsibility to disable these clocks, in the error path of
> > > > ->probe() and during ->remove(), is better managed outside
> > > > tmio_mmc_host_remove(). As a matter of fact, callers of
> > > > tmio_mmc_host_remove() already expects this to be the behaviour.
> > > >
> > > > However, there's a problem with tmio_mmc_host_remove() when the Kconfig
> > > > option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
> > > > disable the clock via runtime PM, which leads to clock enable/disable
> > > > imbalance problems, when the caller of tmio_mmc_host_remove() also tries to
> > > > disable the same clocks.
> > > >
> > > > To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
> > > > device with clocks enabled, but also make sure to disable the IRQs, as we
> > > > normally do at ->runtime_suspend().
> > > >
> > > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >
> > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > (on R-Car Gen2, various Gen3, SH-Mobile AG5, R-Mobile A1, R-Mobile APE6,
> > >  RZ/A1, and RZ/A2)
> >
> > Thanks, Geert! If it is not too much to ask, could you try re-applying
> > commit 7a7dab237027 ("mmc: tmio: remove workaround for NON_REMOVABLE")
> > on top of all these patches and see if your NFS is still stalled?
> >
> > Sidenote: we still need to tackle the problem when SCC hangs because it
> > has no clock. However, I am still interested if all the PM updates have
> > an impact in the beaviour you observed here[1].
> >
> > [1] https://patchwork.kernel.org/patch/11149285/
>
> I reverted "[PATCH] WIP: clk: renesas: rcar-gen3: enable SDnH clk for HS
> modes" (which I still had applied in my local tree), and reapplied "mmc:
> tmio: remove workaround for NON_REMOVABLE", but I cannot reproduce the
> issue, with or without the top 3 commits on mmc/next:
> ff5a1a63febb0761 mmc: tmio: Further fixup runtime PM management at remove
> 774c44ceff3c5b3f mmc: tmio: Make sure the PM domain is 'started' while probing
> 4863bb62a87786ec mmc: renesas_sdhi: remove manual clk handling
>
> Let's see if I can bisect where it was fixed...

Commit 9b0d6855e756b60d ("mmc: renesas_sdhi: enforce manual correction
for Gen3") fixed it.  However, there must be other later changes that
have impact, as reverting 9b0d6855e756b60d and reapplying 7a7dab237027
on both mmc/next~3 and mmc/next gives a working system.

Let's call it a day, no more bisecting today...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

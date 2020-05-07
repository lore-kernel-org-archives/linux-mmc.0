Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402A4C38A2A
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEC120735
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 09:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgEGJXi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 05:23:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45078 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgEGJXi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 05:23:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so3896929otk.12;
        Thu, 07 May 2020 02:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA4qDX0WuPDD4BO6rdrttXuuEk3cYbc8KURmie8fDg4=;
        b=BlxtA8V9cYy0xdwWgd6kcTfThdSroO2KN7Tk12rqChKdLh37oAp9lxDOwznmu/BCQe
         OVZgfREcR8QMvbvf3CdXD/Wd7iVt/ZulHmK/IkJ5zTyXfwAzi2PgxA48/8+ByePLB4jY
         fH1Emk1IttEisgzszpdrCiz3j6xkGynYNJYHbCUI6Ii2+xw+l4ylA3Wueoi0VvKlZ4CD
         swIei0trGDBZfN8xKpGfdBsFxT32kdHWo7mV8IfzlfgNcjt1118REG2pBGOyONS4PPZP
         LoNCDga8WY5wX8ACuMKha48ev3rBqHujyObU0Xxeq9HnFywmiQZx2BucxI7Qvk9D3Iov
         t5ZQ==
X-Gm-Message-State: AGi0PuZN1Wl8cuO8aq9rFrAojA1isXGNhHHp/clwp+A45xdXvcWuQCwm
        8a9/huXjiJE2MqfbUyEfGlzSx+4BeTZCj50nLgs=
X-Google-Smtp-Source: APiQypKSCSvV1/vlj/s+sQYAceM7evP7SaxrT853f41LoruO8tFyrnwUIjwJ7dWjPJeNox4kLvDKzCwZBJBAYoMRTVs=
X-Received: by 2002:a9d:63da:: with SMTP id e26mr3998004otl.107.1588843417472;
 Thu, 07 May 2020 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200501235907.3978-1-angelo.dureghello@timesys.com> <CAPDyKFoLpMTQD+3SnXBNnqVLBMKDf6y=3X+MoPep42SCiQ6+TQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoLpMTQD+3SnXBNnqVLBMKDf6y=3X+MoPep42SCiQ6+TQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 May 2020 11:23:26 +0200
Message-ID: <CAMuHMdUQJHvBmyGQEqhr39dh60EVF6ySnpjV3qJL4d2tot62JQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: mcf5441x: add support for esdhc mmc controller
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Greg ;-)

On Thu, May 7, 2020 at 11:14 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Geert
>
> On Sat, 2 May 2020 at 01:54, Angelo Dureghello
> <angelo.dureghello@timesys.com> wrote:
> >
> > Add support for sdhci-edshc mmc controller.
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> > ---
> > Changes for v3:
> > - removed volatile cast from clk.c
> > ---
> >  arch/m68k/coldfire/clk.c                    | 15 ++++++++++
> >  arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
> >  arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
> >  arch/m68k/include/asm/m5441xsim.h           | 19 ++++++++++++
> >  arch/m68k/include/asm/mcfclk.h              |  2 ++
> >  include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
> >  6 files changed, 95 insertions(+), 3 deletions(-)
> >  create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
>
> Not sure what's the best way to deal with this patch. I looped in
> Geert to get some input.
>
> If it looks okay and the risk is minimal for conflicts, I can carry it
> via my tree, but then I need an ack from Geert.

s/Geert/Greg/, who goes over Coldfire support.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
Date: Thu, 26 Jul 2018 11:28:04 +0200
Message-ID: <CAMuHMdX3zaeXsw799xnWKcZdVjP3r_n=NM-ihXzuSbnU5xF5jw@mail.gmail.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
 <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com>
 <CAMuHMdUnYiLYO4hX3x6X7EZ8HnnOHXCPEUOXzPVJc=6s7VF+bQ@mail.gmail.com> <CAK7LNAT9nHCnq90tgomDnwF6RwSa9BGTnxqzgvVwqy-QBy+qxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAT9nHCnq90tgomDnwF6RwSa9BGTnxqzgvVwqy-QBy+qxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Yamada-san,

On Thu, Jul 26, 2018 at 11:15 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-07-26 17:25 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> > On Thu, Jul 26, 2018 at 5:33 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> This commit renames files as follows:
> >>
> >>   tmio_mmc_core.c              -> tmio_mmc.c
> >>   tmio_mmc.c                   -> tmio_mmc_original.c
> >>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
> >>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
> >>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
> >>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
> >
> > I have mixed feelings about the last two renames, especially about the last
> > one: SYS-DMAC is very Renesas-specific, as it's a separate IP block in
> > Renesas SoCs.

> > 2. Are there other SoCs using an external DMAC?
>
> Yes.  Some old SoCs in UniPhier SoC family rely on
> the external DMAC, like renesas_sdhi_sys_dmac.c
>
> >    Is the interface to the external DMAC similar?
> >    If yes, perhaps it should be renamed to tmio_mmc_sdhi_external_dmac.c?
>
> "sdhi" is already Renesas-specific name, isn't it?

Right, I'm mixing up SDHI and SDHC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

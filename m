From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3 v5] mmc: sh_mmcif: calculate best clock with parent clock
Date: Wed, 13 May 2015 10:43:53 +0200
Message-ID: <CAMuHMdXXQyvBBUGA022vh2B9wWcWusi6xxjJgmY6fPFxoV4Cfw@mail.gmail.com>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87a8x9fck7.wl%kuninori.morimoto.gx@renesas.com>
	<87617xfchj.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdV5aVEqEkOi5sk4rB2NoqzWBp2NvtP=k4pXJ0JjNeKo1w@mail.gmail.com>
	<87mw18euww.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36451 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbbEMIny (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 04:43:54 -0400
In-Reply-To: <87mw18euww.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>

Hi Morimoto-san,

On Wed, May 13, 2015 at 10:37 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > +static const struct sh_mmcif_ver sh_mmcif_gen2 = {
>> > +       .clkdiv_map     = 0x3ff,
>> > +       .pf_min         = 12187500,
>> > +       .pf_max         = 97500000,
>>
>> By any chance, does setting "max-frequency = <97500000>" from the standard
>> MMC DT bindings have the same effect?
>
> I'm still not understanding about this.
> If we can specify SoC (via compatible), the clock frequency limitation
> can be specified in same time.
> Why do we need to have flexibility for it ?

It's better if you don't need to update the C source file for every new SoC,
especially if you can use a standard MMC DT property instead.
Still, you need it for clkdiv_map, right?

> What is yuur "any chance" mean ?

Just ignore those words.

Does setting "max-frequency = <97500000>" have the same effect as specifying
the parent clock upper limit in C?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

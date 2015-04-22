From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3 v3] mmc: sh_mmcif: calculate best clock with parent clock
Date: Wed, 22 Apr 2015 09:49:58 +0200
Message-ID: <CAMuHMdVcHT-QaPc94CS85B5aX_8xe9LTxzGJzY3a5LriQq+wHQ@mail.gmail.com>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87vbgpubvr.wl%kuninori.morimoto.gx@renesas.com>
	<87r3rdubmv.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUM4Cizij6q+6o9mADF_UjkzpZSvsUCdG+Y=PHo=A_qLw@mail.gmail.com>
	<87oamhm0uv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36731 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964979AbbDVHt7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 03:49:59 -0400
In-Reply-To: <87oamhm0uv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>

Hi Morimoto-san,

On Wed, Apr 22, 2015 at 3:04 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > +static const struct sh_mmcif_parent_clk mmcif_gen2_parent_clk = {
>> > +       .max = 97500000,
>> > +       .min = 12187500,
>> > +       .clkdiv_map = 0x3ff,
>>
>> Shouldn't this come from private data in the CPG clock driver, which supplies
>> the parent clock? Then the mmcif driver will be independent from the parent
>> clock.
>
> As Laurent mentioned in other feedback, parent clock (= CFG::MMCxCKCR)
> is div6, and it can set 1/1 - 1/64 (= 780000000 - 12187500)
> But, MMC can use 1/8 - 1/64 (= 97500000 - 12187500), we don't know this limit
> came from. we thought that having limit on DIV6 is not good idea.

So the upper limit is a limitation of the MMCIF hardware, while the lower
limit is a limitation of the CPG.

Then the upper limit should be either in the driver (as you did, using
different compatible values), or it can be described in DT.
(cfr. "git grep max.*freq -- arch/arm/boot/dts/").
Personally, I'm leaning towards the latter.

IMHO the lower limit doesn't belong here.

>> > +               /* FIXME */
>> > +               if (pclk->max != pclk->min * (pclk->max / pclk->min)) {
>> > +                       dev_err(&host->pd->dev, "not assumed parent clk\n");
>> > +                       return;
>> > +               }
>>
>> Why?
>
> This time, max/min = 97500000/12187500 = 8.
> But, we don't know the future.
> It will be non-assumed result if it was below or similar
> max = 91406250
> min = 12187500 (max = min * 15/2)

You can still calculate a divisor if max is not an integer multiple of min,
can't you?

And currently the check above cannot trigger, as you have hardcoded values
in the driver source that don't trigger it.

>> > +               parent_freq = 0;
>> > +               clkdiv = 0;
>> > +               diff_min = ~0;
>> > +               for (i = pclk->max / pclk->min; i > 0; i--) {
>> > +                       for (j = fls(pclk->clkdiv_map); j >= 0; j--) {
>> > +                               if (!((1 << j) & pclk->clkdiv_map))
>> > +                                       continue;
>> > +
>> > +                               myclk = ((pclk->min * i) / (1 << (j + 1)));
>> > +                               diff = (myclk > clk) ? myclk - clk : clk - myclk;
>> > +
>> > +                               if (diff <= diff_min) {
>> > +                                       parent_freq = pclk->min * i;
>> > +                                       clkdiv = j;
>> > +                                       diff_min = diff;
>> > +                               }
>> > +                       }
>> > +               }
>>
>> Shouldn't the above be handled by the CPG clock driver, through a clk API?
>
> I don't think so.
> it calculates best of parent clock (= from CPG) and divider (= from MMC)
> Why CPG driver need to care about MMC's divider ??

The MMCIF driver shouldn't need to be aware of the possible values supported
by the CPG driver.

Can't you loop over all MMC dividers, and
  1. calculate the needed parent clock rate for that MMC divider,
  2. use clk_set_rate_range()[*] to find a (close) parent clock rate,
  3. calculate the effective clock rate based on MMC divider and parent
     clock rate.
and use the best effective clock rate found?

[*] It's a pity the clk API doesn't seem to have a function to query or check
    clock rates without actually setting them. Or am I missing something?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

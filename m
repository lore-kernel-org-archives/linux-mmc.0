From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3 v3] mmc: sh_mmcif: calculate best clock with parent clock
Date: Wed, 22 Apr 2015 10:22:22 +0200
Message-ID: <CAMuHMdX_B7imUB3mrkJVi88Xs-K8h-KTAhHZHnMwJ2AVhCVtEQ@mail.gmail.com>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87vbgpubvr.wl%kuninori.morimoto.gx@renesas.com>
	<87r3rdubmv.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUM4Cizij6q+6o9mADF_UjkzpZSvsUCdG+Y=PHo=A_qLw@mail.gmail.com>
	<87oamhm0uv.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVcHT-QaPc94CS85B5aX_8xe9LTxzGJzY3a5LriQq+wHQ@mail.gmail.com>
	<CAPDyKFrxJaWpn6UqP7aE-uM2cexPejgvG9WOtkTn8=cw1yzqtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:32832 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934324AbbDVIWX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 04:22:23 -0400
In-Reply-To: <CAPDyKFrxJaWpn6UqP7aE-uM2cexPejgvG9WOtkTn8=cw1yzqtg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>

On Wed, Apr 22, 2015 at 10:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The MMCIF driver shouldn't need to be aware of the possible values supported
>> by the CPG driver.
>>
>> Can't you loop over all MMC dividers, and
>>   1. calculate the needed parent clock rate for that MMC divider,
>>   2. use clk_set_rate_range()[*] to find a (close) parent clock rate,
>>   3. calculate the effective clock rate based on MMC divider and parent
>>      clock rate.
>> and use the best effective clock rate found?
>>
>> [*] It's a pity the clk API doesn't seem to have a function to query or check
>>     clock rates without actually setting them. Or am I missing something?
>
> What about clk_round_rate(), can't that be used?

Thanks, I knew there had to be something, but couldn't find it at first sight.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

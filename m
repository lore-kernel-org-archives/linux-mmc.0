From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFT] mmc: tmio: fix CMD12 (STOP) handling
Date: Tue, 4 Jul 2017 15:21:26 +0200
Message-ID: <CAMuHMdU10uTRAeO3bJkG+7de+mP3okG3uPi4e3+hxmkq5Q9eYA@mail.gmail.com>
References: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34833 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdGDNV2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jul 2017 09:21:28 -0400
In-Reply-To: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, =?UTF-8?B?SmFuIEtsw7Z0emtl?= <jan.kloetzke@technisat.de>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Kouei Abe <kouei.abe.cp@renesas.com>

Hi Wolfram,

On Mon, Jul 3, 2017 at 9:28 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> I always anticipated this code to be not correct, but now I had a test
> case to prove it. According to all documentation I have, setting the
> TMIO_STOP_STP bit ever only worked during block transfers. This bit is
> like manually enforcing an autocmd12 during a so far seamless transfer.
> It does NOT work when the block transfer had errors. It also does NOT
> work with any other cmd except block commands. For all those, CMD12 has
> to be treated like any other command. So, basically, we could use this
> bit only for mrq->data->stop cmds. But for these, we happily use the
> autocmd12 feature using the TMIO_STOP_SEC bit. As a result, the above
> bit is not useful for us and we need to treat CMD12 as a regular cmd
> always. Just remove the special handling code. Note that the BSP
> recognized this issue as well yet had a more cautious solution to the
> problem [1]. Which is understandable but makes CMD12 handling even more
> complicated.
>
> Checked with a Renesas Salvator-X/M3-W which needed to send CMD12 when
> retuning one of my SD cards.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=2838a2ff8ca776f6d18b7fbbe75f3df8dd64183a
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> So, this is a friendly call for further testing to make sure no regressions
> happen. I also put the authors of the BSP patch to CC to check if this patch
> also matches their use case. I hope this is fine for these people, please
> accept my apologies if not. I just really like to have your opinion on this
> patch.
>
> Geert, Simon: any chance you can run this patch on your board farms?

I've booted all my boards with your patch applied, no visible differences.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

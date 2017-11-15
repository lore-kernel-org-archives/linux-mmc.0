From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFT] mmc: core: use usleep_range rather than HZ magic in mmc_delay()
Date: Wed, 15 Nov 2017 13:51:31 +0100
Message-ID: <CAMuHMdWXXUCKMs94NK_40BQj-6YVGeu41Z6DJAjwqRf1yZe_-A@mail.gmail.com>
References: <20171114225520.6793-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:51628 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbdKOMvd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Nov 2017 07:51:33 -0500
In-Reply-To: <20171114225520.6793-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram,

On Tue, Nov 14, 2017 at 11:55 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Documentation/timers/timers-howto.txt recommends to use usleep_range for
> delays 1-20ms. Let's adhere to it. No need for messing with HZ and still
> do busy looping these days.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Here is a more detailed test page for this describing my tests:
>
> https://elinux.org/Tests:mmc-delay-refactor
>
> I did mainly test the insert/eject cycle because powering up the cards
> seemed to trigger most delays. Transferring data did not cause any calls
> to mmc_delay() for me. Please let me know if someone knows a test pattern
> which should be included before applying this change.

JFTR, with CONFIG_DEBUG_ATOMIC_SLEEP=y, I assume ?
(also for the other patch)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

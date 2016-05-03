From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 0/4] mmc: tmio/sdhi: prevent regressions when setting clock
Date: Tue, 3 May 2016 09:30:28 +0200
Message-ID: <CAMuHMdXWuBqwLo+SRmnQ=gfH1YkQ-xPrxNWR4gnDdgQPvC05pQ@mail.gmail.com>
References: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34441 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbcECHa3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2016 03:30:29 -0400
In-Reply-To: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Hi Wolfram,

On Mon, May 2, 2016 at 10:25 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Here is a small refactoring series for setting the clock for SDHI cores. This
> is to prevent regression on platforms where this feature has not been tested.
> One such regression is known on r8a7740 (patches 2+3). Patch 4 fixes an
> oversight and patch 1 is a small cleanup.
>
> RFC for now since I can't test these patches on my hardware currently. Will do
> so on Wednesday, probably. Posting now since because Geert may already want to
> test on r8a7740. Branch is here:

Thanks, I can confirm the HP clock is back to 99 MHz (from 12.375 MHz)
on r8a7740/armadillo, so

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/2] mmc: sh_mobile_sdhi: use SDR & card_busy only on Gen2+
Date: Thu, 25 Aug 2016 10:20:02 +0200
Message-ID: <CAMuHMdVOWnr6c2tnEi1j1WAZKYuW-m1R0-OqiZpktJ4fJRJkDA@mail.gmail.com>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Wed, Aug 24, 2016 at 11:34 AM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This series hopefully fixes a performance regression for r8a73a4 (pre Gen2)
> caused by a not working card_busy. Because we don't have documentation for its
> SDHI (and I don't have the hardware), just enable card_busy and SDR only for
> machines known to have hardware support for it.

Thanks, ape6evm is much more rensponsive with your 2 patches applied.

> Geert, can you test, please?

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

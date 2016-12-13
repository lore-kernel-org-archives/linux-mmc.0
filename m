From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/9] mmc: sh_mobile_sdhi: simplify accessing DT data
Date: Tue, 13 Dec 2016 11:48:34 +0100
Message-ID: <CAMuHMdWQQvA9bOdY-Yf_-eJvNRiMrEdqr_K7GCxsf_KeWdBxbw@mail.gmail.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com> <20161212195128.16633-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161212195128.16633-2-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 12, 2016 at 8:51 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> By using the helper of_device_get_match_data(), we can skip some
> checking and make the code simpler.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

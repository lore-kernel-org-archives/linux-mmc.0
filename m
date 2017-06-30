From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] mmc: tmio: remove obsolete TMIO_BBS
Date: Fri, 30 Jun 2017 13:30:49 +0200
Message-ID: <CAMuHMdVaQG5+-XRfycONtC0pgfJNjdnAyf2+62CuopdWrpqDRQ@mail.gmail.com>
References: <20170630105649.16137-1-wsa+renesas@sang-engineering.com> <20170630105649.16137-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170630105649.16137-2-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 30, 2017 at 12:56 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Since commit 10c7fcbd0f00a0 ("ARM: shmobile: sh7372: Remove ZBOOT
> MMC/SDHI support"), this define is not needed anymore.
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

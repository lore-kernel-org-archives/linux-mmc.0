From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
Date: Fri, 30 Aug 2019 09:21:45 +0200
Message-ID: <CAMuHMdVe_d6N8hhG0VNZMKAGwXm7kiOQVnqNkL9+6DbkBsKAZw@mail.gmail.com>
References: <20190829183634.3376-1-tszucs@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829183634.3376-1-tszucs@protonmail.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Tamás,

On Thu, Aug 29, 2019 at 8:37 PM Tamás Szűcs <tszucs@protonmail.ch> wrote:
> Save set clock in mmc_host actual_clock enabling exporting it via debugfs.
> This will indicate the precise SD clock in I/O settings rather than only the
> sometimes misleading requested clock.
>
> Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, one question below.

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -166,10 +166,13 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>
> -       if (new_clock == 0)
> +       if (new_clock == 0) {
> +               host->mmc->actual_clock = 0;

The actual clock is present in the debugfs output only when non-zero.
Hence userspace cannot distinguish between an old kernel where the
Renesas SDHI driver didn't fill in actual_clock, and a new kernel when
the SDHI controller is powered down.
Could that be an issue? Should the old value be retained?
Probably it's OK, as this is debugfs, not an official ABI.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

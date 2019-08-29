From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: sdhi: fill in actual_clock
Date: Thu, 29 Aug 2019 09:47:31 +0200
Message-ID: <CAMuHMdWcp-3B7ZZjbyo02ECyzDX_rQxXF645OCutCkjUu_jWaA@mail.gmail.com>
References: <20190828185518.4340-1-tszucs@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828185518.4340-1-tszucs@protonmail.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Tamás,

On Wed, Aug 28, 2019 at 9:02 PM Tamás Szűcs <tszucs@protonmail.ch> wrote:
> Save set clock in mmc_host actual_clock enabling exporting it via debugfs.
> This will indicate the precise SD clock in I/O settings rather than only the
> sometimes misleading requested clock.
>
> Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -124,7 +124,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
>  {
>         struct renesas_sdhi *priv = host_to_priv(host);
>         unsigned int freq, diff, best_freq = 0, diff_min = ~0;
> -       int i, ret;
> +       int i;
>
>         /* tested only on R-Car Gen2+ currently; may work for others */
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> @@ -153,9 +153,11 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
>                 }
>         }
>
> -       ret = clk_set_rate(priv->clk, best_freq);
> +       host->mmc->actual_clock =
> +               clk_set_rate(priv->clk, best_freq) == 0 ?
> +                       best_freq : clk_get_rate(priv->clk);

When clk_set_rate() returns 0 to indicate success, it may still have
rounded the requested clock rate, no?
So wouldn't it be better to always call clk_get_rate()?
>
> -       return ret == 0 ? best_freq : clk_get_rate(priv->clk);
> +       return host->mmc->actual_clock;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

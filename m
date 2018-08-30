From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 5/6] mmc: renesas_sdhi: merge clk_{start,stop}
 functions to set_clock
Date: Thu, 30 Aug 2018 14:30:23 +0200
Message-ID: <CAPDyKFp-ziw_4zQGAj06YtHZbToiOenWXgxNLpsToPDtuU9tPw@mail.gmail.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com> <1534999460-15111-6-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534999460-15111-6-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2018 at 06:44, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> renesas_sdhi_clk_start() and renesas_sdhi_clk_stop() are now only
> called from renesas_sdhi_set_clock().  Merge them.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/mmc/host/renesas_sdhi_core.c | 38 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index cb6e889..0e88737 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -155,35 +155,17 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
>         return ret == 0 ? best_freq : clk_get_rate(priv->clk);
>  }
>
> -static void renesas_sdhi_clk_start(struct tmio_mmc_host *host)
> +static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
> +                                  unsigned int new_clock)
>  {
> -       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
> -               sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> -
> -       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> -       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> -               usleep_range(10000, 11000);
> -}
> +       u32 clk = 0, clock;
>
> -static void renesas_sdhi_clk_stop(struct tmio_mmc_host *host)
> -{
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>
> -       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> -       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> -               usleep_range(10000, 11000);
> -}
> -
> -static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
> -                                  unsigned int new_clock)
> -{
> -       u32 clk = 0, clock;
> +       if (new_clock == 0)
> +               goto out;
>
> -       if (new_clock == 0) {
> -               renesas_sdhi_clk_stop(host);
> -               return;
> -       }
>         /*
>          * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
>          * set 400MHz to distinguish the CPG settings in HS400.
> @@ -206,13 +188,17 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>                         clk &= ~0xff;
>         }
>
> -       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> -                       sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
>                 usleep_range(10000, 11000);
>
> -       renesas_sdhi_clk_start(host);
> +       sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
> +               sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +
> +out:
> +       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> +       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> +               usleep_range(10000, 11000);
>  }
>
>  static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
> --
> 2.7.4
>

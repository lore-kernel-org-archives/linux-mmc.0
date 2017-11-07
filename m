From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: Replace msleep() of 20ms or less with usleep_range()
Date: Tue, 7 Nov 2017 14:23:40 +0100
Message-ID: <CAPDyKFqQZXvtf2CJ2qxrWNjKuAof-RbE21Mrni9rBTJKZpJVwA@mail.gmail.com>
References: <20171103093628.13108-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171103093628.13108-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 November 2017 at 10:36, Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>
> As documented in Documentation/timers/timers-howto.txt
> as follows, replace msleep() with usleep_range().
>
> msleep(1~20) may not do what the caller intends, and
> will often sleep longer (~20 ms actual sleep for any
> value given in the 1~20ms range). In many cases this
> is not the desired behavior.
>
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v1 [Simon Horman]
> * Extend to cover all instances of msleep(<20);
>
> v0 [Masaharu Hayakawa]
>
> This patch is based on a patch in BSP v3.5.6
> ---
>  drivers/mmc/host/tmio_mmc_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 4c8198f8b04a..583bf3262df5 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -167,11 +167,11 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
>
>         /* HW engineers overrode docs: no sleep needed on R-Car2+ */
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> -               msleep(10);
> +               usleep_range(10000, 11000);
>
>         if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
>                 sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
> -               msleep(10);
> +               usleep_range(10000, 11000);
>         }
>  }
>
> @@ -179,7 +179,7 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
>  {
>         if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
>                 sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
> -               msleep(10);
> +               usleep_range(10000, 11000);
>         }
>
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> @@ -187,7 +187,7 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
>
>         /* HW engineers overrode docs: no sleep needed on R-Car2+ */
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> -               msleep(10);
> +               usleep_range(10000, 11000);
>  }
>
>  static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
> @@ -219,7 +219,7 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
>                         sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
>         if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> -               msleep(10);
> +               usleep_range(10000, 11000);
>
>         tmio_mmc_clk_start(host);
>  }
> @@ -230,11 +230,11 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
>         sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
>         if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
>                 sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> -       msleep(10);
> +       usleep_range(10000, 11000);
>         sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
>         if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
>                 sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> -       msleep(10);
> +       usleep_range(10000, 11000);
>
>         if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
>                 sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

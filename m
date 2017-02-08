From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/9] mmc: meson: Assign the minimum clk rate as close
 to 400KHz as possible
Date: Wed, 8 Feb 2017 12:51:42 +0100
Message-ID: <CAPDyKFr4_tNjuK=Aqsqm0A2bP2-=KtZ-66BtbP_E9QR0pxVRiQ@mail.gmail.com>
References: <d24ae9fb-a4e3-50ab-0144-0ae39bf3ca1c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34510 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbdBHMUZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 07:20:25 -0500
Received: by mail-vk0-f43.google.com with SMTP id r136so99329053vke.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 04:19:34 -0800 (PST)
In-Reply-To: <d24ae9fb-a4e3-50ab-0144-0ae39bf3ca1c@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

On 7 February 2017 at 22:33, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> The current code dealing with calculating mmc->f_min is a bit complicated.
> Additionally, the attempt to set an initial clock rate should explicitly
> use a rate between 100KHz to 400 KHz, according the (e)MMC/SD specs, which
> it doesn't.
>
> Fix the problem and clean up the code by using clk_round_rate() to pick the
> nearest minimum rate to 400KHz (rounded down from 400kHz).
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

I have applied the series for next.

However, I think I deserve to keep the authorship of $subject patch,
so I re-claimed it. Instead I added a line in the change log of what
you changed.

Thanks and kind regards
Uffe

> ---
> v3:
> - remove now unused member mux_parent_rate from struct meson_host
> - change target min rate from 100kHz to 400kHz because actual min rate
>   on meson is 380kHz. Therefore 100kHz would be rounded down to 0.
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 5eca88bc..ef2ce725 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -132,7 +132,6 @@ struct meson_host {
>         struct clk_mux mux;
>         struct clk *mux_clk;
>         struct clk *mux_parent[MUX_CLK_NUM_PARENTS];
> -       unsigned long mux_parent_rate[MUX_CLK_NUM_PARENTS];
>
>         struct clk_divider cfg_div;
>         struct clk *cfg_div_clk;
> @@ -240,7 +239,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
>         const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
>         unsigned int mux_parent_count = 0;
>         const char *clk_div_parents[1];
> -       unsigned int f_min = UINT_MAX;
>         u32 clk_reg, cfg;
>
>         /* get the mux parents */
> @@ -257,20 +255,10 @@ static int meson_mmc_clk_init(struct meson_host *host)
>                         return ret;
>                 }
>
> -               host->mux_parent_rate[i] = clk_get_rate(host->mux_parent[i]);
>                 mux_parent_names[i] = __clk_get_name(host->mux_parent[i]);
>                 mux_parent_count++;
> -               if (host->mux_parent_rate[i] < f_min)
> -                       f_min = host->mux_parent_rate[i];
>         }
>
> -       /* cacluate f_min based on input clocks, and max divider value */
> -       if (f_min != UINT_MAX)
> -               f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
> -       else
> -               f_min = 4000000;  /* default min: 400 MHz */
> -       host->mmc->f_min = f_min;
> -
>         /* create the mux */
>         snprintf(clk_name, sizeof(clk_name), "%s#mux", dev_name(host->dev));
>         init.name = clk_name;
> @@ -325,9 +313,13 @@ static int meson_mmc_clk_init(struct meson_host *host)
>         writel(cfg, host->regs + SD_EMMC_CFG);
>
>         ret = clk_prepare_enable(host->cfg_div_clk);
> -       if (!ret)
> -               ret = meson_mmc_clk_set(host, f_min);
> +       if (ret)
> +               return ret;
> +
> +       /* Get the nearest minimum clock to 400KHz */
> +       host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
>
> +       ret = meson_mmc_clk_set(host, host->mmc->f_min);
>         if (!ret)
>                 clk_disable_unprepare(host->cfg_div_clk);
>
> --
> 2.11.0
>

From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH 03/14] mmc: dw_mmc: exynos: adjust the clock rate with
 speed mode
Date: Wed, 21 Aug 2013 08:20:44 -0700
Message-ID: <CANEJEGvkY4ymiXT-K=6rG+MWin9Bm8y70T1yZ16gcDYak3C=Vg@mail.gmail.com>
References: <002801ce9e75$53f265c0$fbd73140$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54308 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3HUPUp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 11:20:45 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so1057639obc.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2013 08:20:45 -0700 (PDT)
In-Reply-To: <002801ce9e75$53f265c0$fbd73140$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>

On Wed, Aug 21, 2013 at 6:49 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Exynos's host has divider logic before 'cclk_in' to controller core.
> It means that actual clock rate of ciu clock comes from this divider
> value. So, source clock should be adjusted along with 'ciu_div' which
> indicates the host's divider ratio. Setting clock rate basically fits
> the required speed. Specially, 'cclk_in' should have double rate of
> target speed in case of DDR 8-bit mode.

I've refactored this code in ChromeOS-3.4 kernel.
Please see references to dw_mci_exynos_set_bus_hz() in:
    https://gerrit.chromium.org/gerrit/#/c/57861/9/drivers/mmc/host/dw_mmc-exynos.c

Have you considered using that code? Perhaps Alim didn't point out
this work to you?

It might be easier to read here:
    http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=blob;f=drivers/mmc/host/dw_mmc.c;h=41ff5a0d79dffb488a413c51ba14024d4dda1275;hb=refs/heads/chromeos-3.4

The same code was adopted for ChromeOS-3.8 kernel tree:
    http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel-next.git;a=commitdiff;h=39ae94e55a0ad4584b5ff85e2a342a5f867c4d21

    http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel-next.git;a=history;f=drivers/mmc/host/dw_mmc-exynos.c;h=a8288d4c9fac8b89dadff5d4bde469c43171c9cf;hb=refs/heads/chromeos-3.8

thanks,
grant

>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |   44 ++++++++++++++++++++++++++++---------
>  1 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 90f9335..f16e2fc 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -49,6 +49,7 @@ struct dw_mci_exynos_priv_data {
>         u8                              ciu_div;
>         u32                             sdr_timing;
>         u32                             ddr_timing;
> +       u32                             cur_speed;
>  };
>
>  static struct dw_mci_exynos_compatible {
> @@ -91,14 +92,9 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>  static int dw_mci_exynos_setup_clock(struct dw_mci *host)
>  {
>         struct dw_mci_exynos_priv_data *priv = host->priv;
> +       unsigned long rate = clk_get_rate(host->ciu_clk);
>
> -       if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250)
> -               host->bus_hz /= (priv->ciu_div + 1);
> -       else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
> -               host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
> -       else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
> -               host->bus_hz /= EXYNOS4210_FIXED_CIU_CLK_DIV;
> -
> +       host->bus_hz = rate / (priv->ciu_div + 1);
>         return 0;
>  }
>
> @@ -118,11 +114,31 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>  static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         struct dw_mci_exynos_priv_data *priv = host->priv;
> +       unsigned int wanted = ios->clock;
> +       unsigned long actual;
> +       u8 div = priv->ciu_div + 1;
> +
>
> -       if (ios->timing == MMC_TIMING_UHS_DDR50)
> +       if (ios->timing == MMC_TIMING_UHS_DDR50) {
>                 mci_writel(host, CLKSEL, priv->ddr_timing);
> -       else
> +               /* Should be double rate for DDR mode */
> +               if (ios->bus_width == MMC_BUS_WIDTH_8)
> +                       wanted <<= 1;
> +       } else {
>                 mci_writel(host, CLKSEL, priv->sdr_timing);
> +       }
> +
> +       if (wanted && (priv->cur_speed != wanted)) {
> +               int ret = clk_set_rate(host->ciu_clk, wanted * div);
> +               if (ret)
> +                       dev_warn(host->dev,
> +                               "failed to set clk-rate %u error: %d\n",
> +                                wanted * div, ret);
> +               actual = clk_get_rate(host->ciu_clk);
> +               host->bus_hz = actual / div;
> +               priv->cur_speed = wanted;
> +               host->current_speed = 0;
> +       }
>  }
>
>  static int dw_mci_exynos_parse_dt(struct dw_mci *host)
> @@ -133,8 +149,14 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>         u32 div = 0;
>         int ret;
>
> -       of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
> -       priv->ciu_div = div;
> +       if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
> +               priv->ciu_div = EXYNOS4412_FIXED_CIU_CLK_DIV - 1;
> +       else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
> +               priv->ciu_div = EXYNOS4210_FIXED_CIU_CLK_DIV - 1;
> +       else {
> +               of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
> +               priv->ciu_div = div;
> +       }
>
>         ret = of_property_read_u32_array(np,
>                         "samsung,dw-mshc-sdr-timing", timing, 2);
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

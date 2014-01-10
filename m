From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v9 4/7] mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
Date: Fri, 10 Jan 2014 19:21:55 +0100
Message-ID: <CAOf5uwkVsPA4_kuf4G0JBB9ewb1=HGD5vGMr9pttKuWmAzF1VQ@mail.gmail.com>
References: <1389279062-32291-1-git-send-email-balajitk@ti.com>
	<1389375049-5248-1-git-send-email-balajitk@ti.com>
	<1389375049-5248-5-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1389375049-5248-5-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>, mark.rutland@arm.com
List-Id: linux-mmc@vger.kernel.org

Hi

On Fri, Jan 10, 2014 at 6:30 PM, Balaji T K <balajitk@ti.com> wrote:
> In DT case, PBAIS registers are programmed via regulator,
> use regulator APIs to control PBIAS.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 342be25..0a390f8 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -126,6 +126,10 @@
>  #define OMAP_MMC_MAX_CLOCK     52000000
>  #define DRIVER_NAME            "omap_hsmmc"
>
> +#define VDD_1V8                        1800000         /* 180000 uV */
> +#define VDD_3V0                        3000000         /* 300000 uV */
> +#define VDD_165_195            (ffs(MMC_VDD_165_195) - 1)
> +
>  /*
>   * One controller can have multiple slots, like on some omap boards using
>   * omap.c controller driver. Luckily this is not currently done on any known
> @@ -164,6 +168,8 @@ struct omap_hsmmc_host {
>          */
>         struct  regulator       *vcc;
>         struct  regulator       *vcc_aux;
> +       struct  regulator       *pbias;
> +       bool                    pbias_enabled;
>         int                     pbias_disable;
>         void    __iomem         *base;
>         resource_size_t         mapbase;
> @@ -272,6 +278,15 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>         if (mmc_slot(host).before_set_reg)
>                 mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
>
> +       if (host->pbias) {
> +               if (host->pbias_enabled == 1) {
> +                       ret = regulator_disable(host->pbias);
> +                       if (!ret)
> +                               host->pbias_enabled = 0;
> +               }
> +               regulator_set_voltage(host->pbias, VDD_3V0, VDD_3V0);
> +       }
> +
>         /*
>          * Assume Vcc regulator is used only to power the card ... OMAP
>          * VDDS is used to power the pins, optionally with a transceiver to
> @@ -306,9 +321,29 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>                 }
>         }
>
> +       if (host->pbias) {
> +               if (vdd <= VDD_165_195)
> +                       ret = regulator_set_voltage(host->pbias, VDD_1V8,
> +                                                               VDD_1V8);
> +               else
> +                       ret = regulator_set_voltage(host->pbias, VDD_3V0,
> +                                                               VDD_3V0);
> +               if (ret < 0)
> +                       goto error_set_power;
> +
> +               if (host->pbias_enabled == 0) {
> +                       ret = regulator_enable(host->pbias);
> +                       if (!ret) {
> +                               host->pbias_enabled = 1;
> +                               goto error_set_power;

why you a goto to error_set_power if the regulator enable was a succes?
and if pbias_enabled is used for verify if is already enabled. Is the
same to use
regulator_is_enabled?

Michael

> +                       }
> +               }
> +       }
> +
>         if (mmc_slot(host).after_set_reg)
>                 mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
>
> +error_set_power:
>         return ret;
>  }
>
> @@ -342,6 +377,9 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>         reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
>         host->vcc_aux = IS_ERR(reg) ? NULL : reg;
>
> +       reg = devm_regulator_get_optional(host->dev, "pbias");
> +       host->pbias = IS_ERR(reg) ? NULL : reg;
> +
>         /* For eMMC do not power off when not in sleep state */
>         if (mmc_slot(host).no_regulator_off_init)
>                 return 0;
> @@ -1808,6 +1846,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         host->base      = ioremap(host->mapbase, SZ_4K);
>         host->power_mode = MMC_POWER_OFF;
>         host->next_data.cookie = 1;
> +       host->pbias_enabled = 0;
>
>         platform_set_drvdata(pdev, host);
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

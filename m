From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Tue, 5 May 2015 09:56:15 +0200
Message-ID: <CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	<1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

On 30 April 2015 at 14:32, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> Implement voltage switch, supporting modes up to SDR-50.
>
> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
>
> This uses two voltage regulators, one external and one on the pfc.

Why two? If there is a parent child relation ship, that should be
handled through the regulator tree, right!? Please elaborate.

Kind regards
Uffe

>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |   48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 92a58c6007fe..c8538a256e22 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -30,6 +30,7 @@
>  #include <linux/mfd/tmio.h>
>  #include <linux/sh_dma.h>
>  #include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
>
>  #include "tmio_mmc.h"
>
> @@ -84,6 +85,7 @@ MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
>
>  struct sh_mobile_sdhi {
>         struct clk *clk;
> +       struct regulator *vqmmc_ref;
>         struct tmio_mmc_data mmc_data;
>         struct tmio_mmc_dma dma_priv;
>  };
> @@ -148,6 +150,41 @@ static void sh_mobile_sdhi_set_clk_div(struct platform_device *pdev, int clk)
>         }
>  }
>
> +static int sh_mobile_sdhi_start_signal_voltage_switch(
> +       struct tmio_mmc_host *host, unsigned char signal_voltage)
> +{
> +       struct sh_mobile_sdhi *priv = host_to_priv(host);
> +       int min_uV, max_uV;
> +       int ret;
> +
> +       if (signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +               min_uV = 2700000;
> +               max_uV = 3600000;
> +       } else if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +               min_uV = 1700000;
> +               max_uV = 1950000;
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       if (!IS_ERR(host->mmc->supply.vqmmc)) {
> +               ret = regulator_set_voltage(host->mmc->supply.vqmmc,
> +                                           min_uV, max_uV);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (!IS_ERR(priv->vqmmc_ref)) {
> +               ret = regulator_set_voltage(priv->vqmmc_ref,
> +                                           min_uV, max_uV);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       usleep_range(5000, 5500);
> +       return 0;
> +}
> +
>  static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
>  {
>         int timeout = 1000;
> @@ -240,6 +277,13 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>                 goto eprobe;
>         }
>
> +       priv->vqmmc_ref = devm_regulator_get_optional(&pdev->dev, "vqmmc-ref");
> +       if (IS_ERR(priv->vqmmc_ref)) {
> +               if (PTR_ERR(priv->vqmmc_ref) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +               dev_info(&pdev->dev, "No vqmmc reference regulator found\n");
> +       }
> +
>         host = tmio_mmc_host_alloc(pdev);
>         if (!host) {
>                 ret = -ENOMEM;
> @@ -253,6 +297,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         host->clk_enable        = sh_mobile_sdhi_clk_enable;
>         host->clk_disable       = sh_mobile_sdhi_clk_disable;
>         host->multi_io_quirk    = sh_mobile_sdhi_multi_io_quirk;
> +
> +       host->start_signal_voltage_switch
> +                               = sh_mobile_sdhi_start_signal_voltage_switch;
> +
>         /* SD control register space size is 0x100, 0x200 for bus_shift=1 */
>         if (resource_size(res) > 0x100)
>                 host->bus_shift = 1;
> --
> 1.7.10.4
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

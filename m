From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: tegra: use mmc_of_parse to get the support of
 standard MMC DT bindings
Date: Thu, 21 Feb 2013 23:44:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302212333330.10403@axis700.grange>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
 <1361343902-15223-3-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361343902-15223-3-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Joseph

On Wed, 20 Feb 2013, Joseph Lo wrote:

> Updating the sdhci-tegra driver to use mmc_of_parse to support standa=
rd
> MMC DT bindings. Then we can remove the redundant code that already s=
upport
> in generic MMC core.
>=20
> Signed-off-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 85 ++++----------------------------=
----------
>  1 file changed, 7 insertions(+), 78 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-=
tegra.c
> index 08b06e9..4f6b5c4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -24,6 +24,7 @@
>  #include <linux/gpio.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
> =20
>  #include <asm/gpio.h>
> =20
> @@ -44,10 +45,7 @@ struct sdhci_tegra_soc_data {
> =20
>  struct sdhci_tegra {
>  	const struct sdhci_tegra_soc_data *soc_data;
> -	int cd_gpio;
> -	int wp_gpio;
>  	int power_gpio;
> -	int is_8bit;
>  };
> =20
>  static u32 tegra_sdhci_readl(struct sdhci_host *host, int reg)
> @@ -107,23 +105,9 @@ static void tegra_sdhci_writel(struct sdhci_host=
 *host, u32 val, int reg)
> =20
>  static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
>  {
> -	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> -	struct sdhci_tegra *tegra_host =3D pltfm_host->priv;
> -
> -	if (!gpio_is_valid(tegra_host->wp_gpio))
> -		return -1;
> -
> -	return gpio_get_value(tegra_host->wp_gpio);
> +	return mmc_gpio_get_ro(host->mmc);
>  }
> =20
> -static irqreturn_t carddetect_irq(int irq, void *data)
> -{
> -	struct sdhci_host *sdhost =3D (struct sdhci_host *)data;
> -
> -	tasklet_schedule(&sdhost->card_tasklet);
> -	return IRQ_HANDLED;
> -};
> -
>  static void tegra_sdhci_reset_exit(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -145,12 +129,11 @@ static void tegra_sdhci_reset_exit(struct sdhci=
_host *host, u8 mask)
> =20
>  static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_wid=
th)
>  {
> -	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> -	struct sdhci_tegra *tegra_host =3D pltfm_host->priv;
>  	u32 ctrl;
> =20
>  	ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
> -	if (tegra_host->is_8bit && bus_width =3D=3D MMC_BUS_WIDTH_8) {
> +	if (host->mmc->caps =3D=3D MMC_CAP_8_BIT_DATA &&

Don't you want to check for just one bit? -=A6caps can contain multiple=
=20
flags set:

+	if ((host->mmc->caps & MMC_CAP_8_BIT_DATA) &&

Thanks
Guennadi

> +	    bus_width =3D=3D MMC_BUS_WIDTH_8) {
>  		ctrl &=3D ~SDHCI_CTRL_4BITBUS;
>  		ctrl |=3D SDHCI_CTRL_8BITBUS;
>  	} else {
> @@ -220,15 +203,12 @@ static void sdhci_tegra_parse_dt(struct device =
*dev,
>  					struct sdhci_tegra *tegra_host)
>  {
>  	struct device_node *np =3D dev->of_node;
> -	u32 bus_width;
> +	struct sdhci_host *host;
> =20
> -	tegra_host->cd_gpio =3D of_get_named_gpio(np, "cd-gpios", 0);
> -	tegra_host->wp_gpio =3D of_get_named_gpio(np, "wp-gpios", 0);
>  	tegra_host->power_gpio =3D of_get_named_gpio(np, "power-gpios", 0);
> =20
> -	if (of_property_read_u32(np, "bus-width", &bus_width) =3D=3D 0 &&
> -	    bus_width =3D=3D 8)
> -		tegra_host->is_8bit =3D 1;
> +	host =3D platform_get_drvdata(to_platform_device(dev));
> +	mmc_of_parse(host->mmc);
>  }
> =20
>  static int sdhci_tegra_probe(struct platform_device *pdev)
> @@ -272,37 +252,6 @@ static int sdhci_tegra_probe(struct platform_dev=
ice *pdev)
>  		gpio_direction_output(tegra_host->power_gpio, 1);
>  	}
> =20
> -	if (gpio_is_valid(tegra_host->cd_gpio)) {
> -		rc =3D gpio_request(tegra_host->cd_gpio, "sdhci_cd");
> -		if (rc) {
> -			dev_err(mmc_dev(host->mmc),
> -				"failed to allocate cd gpio\n");
> -			goto err_cd_req;
> -		}
> -		gpio_direction_input(tegra_host->cd_gpio);
> -
> -		rc =3D request_irq(gpio_to_irq(tegra_host->cd_gpio),
> -				 carddetect_irq,
> -				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> -				 mmc_hostname(host->mmc), host);
> -
> -		if (rc)	{
> -			dev_err(mmc_dev(host->mmc), "request irq error\n");
> -			goto err_cd_irq_req;
> -		}
> -
> -	}
> -
> -	if (gpio_is_valid(tegra_host->wp_gpio)) {
> -		rc =3D gpio_request(tegra_host->wp_gpio, "sdhci_wp");
> -		if (rc) {
> -			dev_err(mmc_dev(host->mmc),
> -				"failed to allocate wp gpio\n");
> -			goto err_wp_req;
> -		}
> -		gpio_direction_input(tegra_host->wp_gpio);
> -	}
> -
>  	clk =3D clk_get(mmc_dev(host->mmc), NULL);
>  	if (IS_ERR(clk)) {
>  		dev_err(mmc_dev(host->mmc), "clk err\n");
> @@ -312,9 +261,6 @@ static int sdhci_tegra_probe(struct platform_devi=
ce *pdev)
>  	clk_prepare_enable(clk);
>  	pltfm_host->clk =3D clk;
> =20
> -	if (tegra_host->is_8bit)
> -		host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> -
>  	rc =3D sdhci_add_host(host);
>  	if (rc)
>  		goto err_add_host;
> @@ -325,15 +271,6 @@ err_add_host:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_put(pltfm_host->clk);
>  err_clk_get:
> -	if (gpio_is_valid(tegra_host->wp_gpio))
> -		gpio_free(tegra_host->wp_gpio);
> -err_wp_req:
> -	if (gpio_is_valid(tegra_host->cd_gpio))
> -		free_irq(gpio_to_irq(tegra_host->cd_gpio), host);
> -err_cd_irq_req:
> -	if (gpio_is_valid(tegra_host->cd_gpio))
> -		gpio_free(tegra_host->cd_gpio);
> -err_cd_req:
>  	if (gpio_is_valid(tegra_host->power_gpio))
>  		gpio_free(tegra_host->power_gpio);
>  err_power_req:
> @@ -351,14 +288,6 @@ static int sdhci_tegra_remove(struct platform_de=
vice *pdev)
> =20
>  	sdhci_remove_host(host, dead);
> =20
> -	if (gpio_is_valid(tegra_host->wp_gpio))
> -		gpio_free(tegra_host->wp_gpio);
> -
> -	if (gpio_is_valid(tegra_host->cd_gpio)) {
> -		free_irq(gpio_to_irq(tegra_host->cd_gpio), host);
> -		gpio_free(tegra_host->cd_gpio);
> -	}
> -
>  	if (gpio_is_valid(tegra_host->power_gpio))
>  		gpio_free(tegra_host->power_gpio);
> =20
> --=20
> 1.8.1.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/

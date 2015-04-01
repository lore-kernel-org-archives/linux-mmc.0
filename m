From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-tegra: convert to use GPIO descriptors
Date: Wed, 1 Apr 2015 12:59:43 +0200
Message-ID: <CAPDyKFpo-c0iS5TCh5b4vGDNfp=57Pf3C16e9OpCLd=tmWBFpQ@mail.gmail.com>
References: <1427751565-30377-1-git-send-email-josserand.mylene@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427751565-30377-1-git-send-email-josserand.mylene@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mylene JOSSERAND <josserand.mylene@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30 March 2015 at 23:39, Mylene JOSSERAND <josserand.mylene@gmail.com> wrote:
> Modify the driver to handle GPIOs using the descriptor API.
>
> Signed-off-by: Mylene JOSSERAND <josserand.mylene@gmail.com>

Thanks! Applied.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c |   32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 93834ab..ad28b49 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -20,11 +20,10 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> -#include <linux/gpio.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
> +#include <linux/gpio/consumer.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -49,7 +48,7 @@ struct sdhci_tegra_soc_data {
>
>  struct sdhci_tegra {
>         const struct sdhci_tegra_soc_data *soc_data;
> -       int power_gpio;
> +       struct gpio_desc *power_gpio;
>  };
>
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -246,17 +245,6 @@ static const struct of_device_id sdhci_tegra_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_tegra_dt_match);
>
> -static int sdhci_tegra_parse_dt(struct device *dev)
> -{
> -       struct device_node *np = dev->of_node;
> -       struct sdhci_host *host = dev_get_drvdata(dev);
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_tegra *tegra_host = pltfm_host->priv;
> -
> -       tegra_host->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
> -       return mmc_of_parse(host->mmc);
> -}
> -
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>         const struct of_device_id *match;
> @@ -286,19 +274,15 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         tegra_host->soc_data = soc_data;
>         pltfm_host->priv = tegra_host;
>
> -       rc = sdhci_tegra_parse_dt(&pdev->dev);
> +       rc = mmc_of_parse(host->mmc);
>         if (rc)
>                 goto err_parse_dt;
>
> -       if (gpio_is_valid(tegra_host->power_gpio)) {
> -               rc = devm_gpio_request(&pdev->dev, tegra_host->power_gpio,
> -                                      "sdhci_power");
> -               if (rc) {
> -                       dev_err(mmc_dev(host->mmc),
> -                               "failed to allocate power gpio\n");
> -                       goto err_power_req;
> -               }
> -               gpio_direction_output(tegra_host->power_gpio, 1);
> +       tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
> +                                                        GPIOD_OUT_HIGH);
> +       if (IS_ERR(tegra_host->power_gpio)) {
> +               rc = PTR_ERR(tegra_host->power_gpio);
> +               goto err_power_req;
>         }
>
>         clk = devm_clk_get(mmc_dev(host->mmc), NULL);
> --
> 1.7.10.4
>

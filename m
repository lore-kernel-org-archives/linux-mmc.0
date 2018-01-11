From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci_f_sdh30: add ACPI support
Date: Thu, 11 Jan 2018 15:53:15 +0100
Message-ID: <CAPDyKFrBbbmLdR961WPEi6ropN=g9AOZ=4CT8V9AQE5d7M-CUw@mail.gmail.com>
References: <20180108154419.2821-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:38217 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933143AbeAKOxQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jan 2018 09:53:16 -0500
Received: by mail-it0-f65.google.com with SMTP id r6so4860231itr.3
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jan 2018 06:53:16 -0800 (PST)
In-Reply-To: <20180108154419.2821-1-ard.biesheuvel@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 8 January 2018 at 16:44, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The Fujitsu SDH30 SDHCI controller may be described as a SCX0002 ACPI
> device on ACPI platforms incorporating the Socionext SynQuacer SoC.
>
> Given that mmc_of_parse() has already been made ACPI/DT agnostic,
> making the SDH30 driver ACPI capable is actually rather simple:
> all we need to do is make the call to sdhci_get_of_property() [which
> does not set any properties we care about] and the clock handling
> dependent on whether we are dealing with a DT device, and exposing
> the ACPI id via the platform_driver struct and the module metadata.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v2: make OF optional now that ACPI is supported
>     drop dev_of_node() check when disabling the clocks - those routines
>     tolerate NULL pointers so there's no need
>
>  drivers/mmc/host/Kconfig         |  2 +-
>  drivers/mmc/host/sdhci_f_sdh30.c | 52 +++++++++++++-------
>  2 files changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 567028c9219a..07ed947ed10b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -320,7 +320,7 @@ config MMC_SDHCI_BCM_KONA
>  config MMC_SDHCI_F_SDH30
>         tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
>         depends on MMC_SDHCI_PLTFM
> -       depends on OF
> +       depends on OF || ACPI
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           Needed by some Fujitsu SoC for MMC / SD / SDIO support.
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 04ca0d33a521..485f7591fae4 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -10,9 +10,11 @@
>   * the Free Software Foundation, version 2 of the License.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/clk.h>
>
> @@ -146,7 +148,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, host);
>
> -       sdhci_get_of_property(pdev);
>         host->hw_name = "f_sdh30";
>         host->ops = &sdhci_f_sdh30_ops;
>         host->irq = irq;
> @@ -158,25 +159,29 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
> -       if (IS_ERR(priv->clk_iface)) {
> -               ret = PTR_ERR(priv->clk_iface);
> -               goto err;
> -       }
> +       if (dev_of_node(dev)) {
> +               sdhci_get_of_property(pdev);
>
> -       ret = clk_prepare_enable(priv->clk_iface);
> -       if (ret)
> -               goto err;
> +               priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
> +               if (IS_ERR(priv->clk_iface)) {
> +                       ret = PTR_ERR(priv->clk_iface);
> +                       goto err;
> +               }
>
> -       priv->clk = devm_clk_get(&pdev->dev, "core");
> -       if (IS_ERR(priv->clk)) {
> -               ret = PTR_ERR(priv->clk);
> -               goto err_clk;
> -       }
> +               ret = clk_prepare_enable(priv->clk_iface);
> +               if (ret)
> +                       goto err;
>
> -       ret = clk_prepare_enable(priv->clk);
> -       if (ret)
> -               goto err_clk;
> +               priv->clk = devm_clk_get(&pdev->dev, "core");
> +               if (IS_ERR(priv->clk)) {
> +                       ret = PTR_ERR(priv->clk);
> +                       goto err_clk;
> +               }
> +
> +               ret = clk_prepare_enable(priv->clk);
> +               if (ret)
> +                       goto err_clk;
> +       }
>
>         /* init vendor specific regs */
>         ctrl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
> @@ -226,16 +231,27 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_OF
>  static const struct of_device_id f_sdh30_dt_ids[] = {
>         { .compatible = "fujitsu,mb86s70-sdhci-3.0" },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id f_sdh30_acpi_ids[] = {
> +       { "SCX0002" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, f_sdh30_acpi_ids);
> +#endif
>
>  static struct platform_driver sdhci_f_sdh30_driver = {
>         .driver = {
>                 .name = "f_sdh30",
> -               .of_match_table = f_sdh30_dt_ids,
> +               .of_match_table = of_match_ptr(f_sdh30_dt_ids),
> +               .acpi_match_table = ACPI_PTR(f_sdh30_acpi_ids),
>                 .pm     = &sdhci_pltfm_pmops,
>         },
>         .probe  = sdhci_f_sdh30_probe,
> --
> 2.11.0
>

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] sdhci-fujitsu: add support for setting the
 CMD_DAT_DELAY attribute
Date: Mon, 6 Nov 2017 16:00:55 +0100
Message-ID: <CAPDyKFoqpAJhZw99CGKATeZJkREqBtfk4Mq9R-E==8cN8Rasog@mail.gmail.com>
References: <20171106114050.15169-1-ard.biesheuvel@linaro.org> <20171106114050.15169-2-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:43812 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbdKFPA5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2017 10:00:57 -0500
Received: by mail-io0-f194.google.com with SMTP id 134so16002564ioo.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Nov 2017 07:00:57 -0800 (PST)
In-Reply-To: <20171106114050.15169-2-ard.biesheuvel@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 6 November 2017 at 12:40, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The Socionext SynQuacer SoC inherits this IP from Fujitsu, but
> requires the F_SDH30_CMD_DAT_DELAY bit to be set in the
> F_SDH30_ESD_CONTROL control register. So set this bit if the
> DT node has the 'fujitsu,cmd-dat-delay-select' property.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 111b66f5439b..c5bf69ef7e40 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/clk.h>
>
>  #include "sdhci-pltfm.h"
> @@ -45,8 +46,9 @@
>  struct f_sdhost_priv {
>         struct clk *clk_iface;
>         struct clk *clk;
> -       u32 vendor_hs200;
>         struct device *dev;
> +       u32 vendor_hs200;

No need to change the above.

> +       bool enable_cmd_dat_delay;
>  };
>
>  static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
> @@ -84,10 +86,19 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>
>  static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>  {
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       u32 ctl;
> +
>         if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
>                 sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
>
>         sdhci_reset(host, mask);
> +
> +       if (priv->enable_cmd_dat_delay) {
> +               ctl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
> +               ctl |= F_SDH30_CMD_DAT_DELAY;
> +               sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
> +       }
>  }
>
>  static const struct sdhci_ops sdhci_f_sdh30_ops = {
> @@ -126,6 +137,11 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>         host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
>                         SDHCI_QUIRK2_TUNING_WORK_AROUND;
>
> +       if (device_property_read_bool(dev, "fujitsu,cmd-dat-delay-select")) {
> +               dev_info(dev, "Setting cmd-dat-delay\n");
> +               priv->enable_cmd_dat_delay = true;
> +       }

I don't think there is need to print something due to the parsing.
Let's instead simplify this with:

priv->enable_cmd_dat_delay = device_property_read_bool(dev,
"fujitsu,cmd-dat-delay-select");

> +
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto err;
> --
> 2.11.0
>

Kind regards
Uffe

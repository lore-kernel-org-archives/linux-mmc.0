From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 7/9] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Mon, 4 Apr 2016 17:04:03 +0200
Message-ID: <CAPDyKFq2HZFw8ZFH0LzYGRBidcKFsmz2D4LrHsm8DviU+ZkGGQ@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
	<1459525479-20842-8-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34799 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbcDDPEE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 11:04:04 -0400
Received: by mail-qg0-f50.google.com with SMTP id c6so24531075qga.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 08:04:04 -0700 (PDT)
In-Reply-To: <1459525479-20842-8-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>

On 1 April 2016 at 17:44, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Implement voltage switch, supporting modes up to SDR-50.
>
> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  3 ++
>  drivers/mmc/host/sh_mobile_sdhi.c                  | 50 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 7fb746dd1a68ca..0f610d4b5b005f 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -26,3 +26,6 @@ Required properties:
>
>  Optional properties:
>  - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
> +- pinctrl-names: should be "default", "state_uhs"
> +- pinctrl-0: should contain default/high speed pin ctrl
> +- pinctrl-1: should contain uhs mode pin ctrl
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 8fd1d6b29190b6..89e0c5e9fcc668 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -32,6 +32,9 @@
>  #include <linux/mfd/tmio.h>
>  #include <linux/sh_dma.h>
>  #include <linux/delay.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pinctrl/pinctrl-state.h>
> +#include <linux/regulator/consumer.h>
>
>  #include "tmio_mmc.h"
>
> @@ -97,6 +100,8 @@ struct sh_mobile_sdhi {
>         struct clk *clk;
>         struct tmio_mmc_data mmc_data;
>         struct tmio_mmc_dma dma_priv;
> +       struct pinctrl *pinctrl;
> +       struct pinctrl_state *pins_default, *pins_uhs;
>  };
>
>  static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
> @@ -205,6 +210,44 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
>         clk_disable_unprepare(priv->clk);
>  }
>
> +static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
> +                                                     struct mmc_ios *ios)
> +{
> +       struct tmio_mmc_host *host = mmc_priv(mmc);
> +       struct sh_mobile_sdhi *priv = host_to_priv(host);
> +       struct pinctrl_state *pin_state;
> +       int ret;
> +
> +       switch (ios->signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_330:
> +               pin_state = priv->pins_default;
> +               break;
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               pin_state = priv->pins_uhs;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * If anything is missing, assume signal voltage is fixed at
> +        * 3.3V and succeed/fail accordingly.
> +        */
> +       if (IS_ERR(priv->pinctrl) || IS_ERR(pin_state))
> +               return ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
> +
> +       ret = mmc_regulator_set_vqmmc(host->mmc, ios);
> +       if (ret)
> +               return ret;
> +
> +       ret = pinctrl_select_state(priv->pinctrl, pin_state);
> +       if (ret)
> +               return ret;
> +
> +       usleep_range(5000, 5500);

Why do you need this delay/sleep?

> +       return 0;
> +}
> +
>  static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
>  {
>         int timeout = 1000;
> @@ -296,6 +339,12 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>                 goto eprobe;
>         }
>
> +       priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (!IS_ERR(priv->pinctrl)) {
> +               priv->pins_default = pinctrl_lookup_state(priv->pinctrl, PINCTRL_STATE_DEFAULT);
> +               priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl, "state_uhs");
> +       }
> +
>         host = tmio_mmc_host_alloc(pdev);
>         if (!host) {
>                 ret = -ENOMEM;
> @@ -319,6 +368,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         host->clk_update        = sh_mobile_sdhi_clk_update;
>         host->clk_disable       = sh_mobile_sdhi_clk_disable;
>         host->multi_io_quirk    = sh_mobile_sdhi_multi_io_quirk;
> +       host->start_signal_voltage_switch = sh_mobile_sdhi_start_signal_voltage_switch;
>
>         /* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
>         if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Kind regards
Uffe

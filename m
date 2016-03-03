From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 5/7] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Thu, 3 Mar 2016 15:47:18 +0100
Message-ID: <CAPDyKFovA5iq2yJ18d6hZussOExJn+0HanKGOLALiDGcxVjJnA@mail.gmail.com>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
	<1455913003-6140-6-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36987 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905AbcCCOrU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 09:47:20 -0500
Received: by mail-wm0-f54.google.com with SMTP id p65so34634123wmp.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2016 06:47:19 -0800 (PST)
In-Reply-To: <1455913003-6140-6-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

On 19 February 2016 at 21:16, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
>
> Implement voltage switch, supporting modes up to SDR-50.
>
> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 57 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 4e2ac0e5e5d415..d044fed2736a15 100644
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
> +       struct pinctrl_state *pinctrl_3v3, *pinctrl_1v8;

May I suggest the following names for the pin states instead?
pins_default
pins_uhs

The corresponding pinctrl state-names I prefer are these:

PINCTRL_STATE_DEFAULT and "state_uhs". These names are currently used by mtk-sd.

>  };
>
>  static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
> @@ -205,6 +210,49 @@ static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
>         clk_disable_unprepare(priv->clk);
>  }
>
> +static int sh_mobile_sdhi_start_signal_voltage_switch(
> +       struct tmio_mmc_host *host, unsigned char signal_voltage)
> +{
> +       struct sh_mobile_sdhi *priv = host_to_priv(host);
> +       struct pinctrl_state *state;
> +       int min_uV, max_uV;
> +       int ret;
> +
> +       switch (signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_330:
> +               min_uV = 2700000;
> +               max_uV = 3600000;
> +               state = priv->pinctrl_3v3;
> +               break;
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               min_uV = 1700000;
> +               max_uV = 1950000;
> +               state = priv->pinctrl_1v8;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * If anything is missing, assume signal voltage is fixed at
> +        * 3.3V and succeed/fail accordingly.
> +        */
> +       if (IS_ERR(host->mmc->supply.vqmmc) ||
> +           IS_ERR(priv->pinctrl) || IS_ERR(state))
> +               return signal_voltage == MMC_SIGNAL_VOLTAGE_330 ? 0 : -EINVAL;
> +
> +       ret = regulator_set_voltage(host->mmc->supply.vqmmc, min_uV, max_uV);
> +       if (ret)
> +               return ret;

You should make use of the mmc_regulator_set_vqmmc() API here instead.

> +
> +       ret = pinctrl_select_state(priv->pinctrl, state);
> +       if (ret)
> +               return ret;
> +
> +       usleep_range(5000, 5500);
> +       return 0;
> +}
> +
>  static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
>  {
>         int timeout = 1000;
> @@ -296,6 +344,14 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>                 goto eprobe;
>         }
>
> +       priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (!IS_ERR(priv->pinctrl)) {
> +               priv->pinctrl_3v3 = pinctrl_lookup_state(priv->pinctrl,
> +                                                        PINCTRL_STATE_DEFAULT);
> +               priv->pinctrl_1v8 = pinctrl_lookup_state(priv->pinctrl,
> +                                                        "1v8");

I am missing a separate DT binding documentation patch related to the
above pinctrls.

> +       }
> +
>         host = tmio_mmc_host_alloc(pdev);
>         if (!host) {
>                 ret = -ENOMEM;
> @@ -319,6 +375,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
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

Kind regards
Uffe

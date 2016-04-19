From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/3] mmc: usdhi6rol0: add pinctrl to set pin drive strength
Date: Tue, 19 Apr 2016 11:45:44 +0200
Message-ID: <CAPDyKFo60PBkOtLRyuDBHVh+LB_d0vcATSuTMu4TWeLsWgQVSw@mail.gmail.com>
References: <cover.1460986983.git.larper@axis.com>
	<181127e4ec8bbfbf0f80018ff157b59d63597c44.1460986983.git.larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36434 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcDSJpq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 05:45:46 -0400
Received: by mail-wm0-f49.google.com with SMTP id v188so154427683wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 02:45:45 -0700 (PDT)
In-Reply-To: <181127e4ec8bbfbf0f80018ff157b59d63597c44.1460986983.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lars Persson <larper@axis.com>

On 18 April 2016 at 15:44, Lars Persson <lars.persson@axis.com> wrote:
> Some boards need different pin drive strength for the UHS mode. Add an
> optional pinctrl setting with two pin states covering UHS speeds and
> other speeds.
>
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  drivers/mmc/host/usdhi6rol0.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 2585ea4..e8a5c8f 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -22,6 +22,7 @@
>  #include <linux/mmc/sdio.h>
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>  #include <linux/string.h>
> @@ -198,6 +199,11 @@ struct usdhi6_host {
>         struct dma_chan *chan_rx;
>         struct dma_chan *chan_tx;
>         bool dma_active;
> +
> +       /* Pin control */
> +       struct pinctrl *pinctrl;
> +       struct pinctrl_state *pins_default;
> +       struct pinctrl_state *pins_uhs;
>  };
>
>  /*                     I/O primitives                                  */
> @@ -1147,14 +1153,39 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         }
>  }
>
> +static int usdhi6_set_pinstates(struct usdhi6_host *host, int voltage)
> +{
> +       if (IS_ERR(host->pinctrl) || IS_ERR(host->pins_default) ||
> +           IS_ERR(host->pins_uhs))

So this means, if you have UHS support you need both default and uhs
pins. That makes sense but it's not according to the DT documentation
in patch 1/3.

> +               return 0;
> +
> +       switch (voltage) {
> +       case MMC_SIGNAL_VOLTAGE_180:
> +       case MMC_SIGNAL_VOLTAGE_120:
> +               return pinctrl_select_state(host->pinctrl,
> +                                           host->pins_uhs);
> +
> +       default:
> +               return pinctrl_select_state(host->pinctrl,
> +                                           host->pins_default);
> +       }
> +}
> +
>  static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         int ret;
>
>         ret = mmc_regulator_set_vqmmc(mmc, ios);

What if you don't have pins for default and uhs state? Should you
verify that's the case before deciding to switch voltage?

>
> -       if (ret < 0)
> +       if (ret < 0) {
>                 dev_warn(mmc_dev(mmc), "Voltage switch failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = usdhi6_set_pinstates(mmc_priv(mmc), ios->signal_voltage);
> +       if (ret)
> +               dev_warn_once(mmc_dev(mmc),
> +                             "Failed to set pinstate err=%d\n", ret);
>
>         return ret;
>  }
> @@ -1817,6 +1848,13 @@ static int usdhi6_probe(struct platform_device *pdev)
>                 mmc->f_max = host->imclk;
>         mmc->f_min = host->imclk / 512;
>
> +       host->pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (!IS_ERR(host->pinctrl)) {
> +               host->pins_default = pinctrl_lookup_state(host->pinctrl,
> +                                                         PINCTRL_STATE_DEFAULT);

According to the DT documentation in patch 1/3, the default pins
should be required and not optional. I assume you want them to be
optional, but required when supporting UHS, right?

> +               host->pins_uhs     = pinctrl_lookup_state(host->pinctrl,
> +                                                         "pins_uhs");
> +       }
>         platform_set_drvdata(pdev, host);
>
>         ret = mmc_add_host(mmc);
> --
> 2.1.4
>

Kind regards
Uffe

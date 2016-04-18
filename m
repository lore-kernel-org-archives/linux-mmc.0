From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Mon, 18 Apr 2016 13:18:24 +0200
Message-ID: <CAPDyKFqTwZG6AA4ALEACM_vuWUTZNymrwzUPzUOcV2euoHKz5w@mail.gmail.com>
References: <cover.1460971625.git.larper@axis.com>
	<ba126adf4953f61ed11ed8b0219608663cfb5fbc.1460971625.git.larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35558 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbcDRLS0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 07:18:26 -0400
Received: by mail-wm0-f44.google.com with SMTP id a140so114918475wma.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2016 04:18:25 -0700 (PDT)
In-Reply-To: <ba126adf4953f61ed11ed8b0219608663cfb5fbc.1460971625.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Phil Edworthy <phil@edworthys.org>, Lars Persson <larper@axis.com>

On 18 April 2016 at 11:38, Lars Persson <lars.persson@axis.com> wrote:
> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> The mmc core will only enable UHS modes if the host supports the
> .start_signal_voltage_switch() operation. Add this method to the v08r07
> driver even if there's actually nothing to do in it.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Phil Edworthy <phil@edworthys.org>
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  drivers/mmc/host/usdhi6rol0.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 807c06e..5dde31b 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/scatterlist.h>
>  #include <linux/string.h>
>  #include <linux/time.h>
> @@ -1147,12 +1148,43 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         }
>  }
>
> +static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       int ret;
> +
> +       if (IS_ERR(mmc->supply.vqmmc))
> +               return 0;
> +
> +       switch (ios->signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_330:
> +               ret = regulator_set_voltage(mmc->supply.vqmmc,
> +                                           2700000, 3600000);
> +               break;
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               ret = regulator_set_voltage(mmc->supply.vqmmc,
> +                                           1700000, 1950000);
> +               break;
> +       case MMC_SIGNAL_VOLTAGE_120:
> +               ret = regulator_set_voltage(mmc->supply.vqmmc,
> +                                           1100000, 1300000);
> +               break;
> +       default:
> +               return 0;
> +       }

Please replace this switch statement with a call to
mmc_regulator_set_vqmmc() instead.

> +
> +       if (ret < 0)
> +               dev_warn(mmc_dev(mmc), "Voltage switch failed: %d\n", ret);
> +
> +       return ret;
> +}
> +
>  static struct mmc_host_ops usdhi6_ops = {
>         .request        = usdhi6_request,
>         .set_ios        = usdhi6_set_ios,
>         .get_cd         = usdhi6_get_cd,
>         .get_ro         = usdhi6_get_ro,
>         .enable_sdio_irq = usdhi6_enable_sdio_irq,
> +       .start_signal_voltage_switch = usdhi6_sig_volt_switch,
>  };
>
>  /*                     State machine handlers                          */
> --
> 2.1.4
>

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Fri, 22 Apr 2016 14:53:40 +0200
Message-ID: <CAPDyKFqFLsSbnt9VgT4PNCC38=d+bjLhYzPTYXr7TOFfTqN14Q@mail.gmail.com>
References: <cover.1461246772.git.larper@axis.com>
	<f53bfd4b14c36df41449d0bfdaadabd2c8d3ab1d.1461246772.git.larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38439 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcDVMxm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2016 08:53:42 -0400
Received: by mail-wm0-f49.google.com with SMTP id u206so25487045wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2016 05:53:41 -0700 (PDT)
In-Reply-To: <f53bfd4b14c36df41449d0bfdaadabd2c8d3ab1d.1461246772.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lars Persson <larper@axis.com>

On 21 April 2016 at 15:55, Lars Persson <lars.persson@axis.com> wrote:
> Add a start_signal_voltage_switch() operation to support enabling of
> UHS modes.
>
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  drivers/mmc/host/usdhi6rol0.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 807c06e..28fe5c7 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -21,6 +21,7 @@
>  #include <linux/mmc/sd.h>
>  #include <linux/mmc/sdio.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
> @@ -1147,12 +1148,22 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         }
>  }
>
> +static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       int ret;
> +
> +       ret = mmc_regulator_set_vqmmc(mmc, ios);
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
> @@ -1785,7 +1796,17 @@ static int usdhi6_probe(struct platform_device *pdev)
>
>         mmc->ops = &usdhi6_ops;
>         mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -               MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_DDR50 | MMC_CAP_SDIO_IRQ;

Oh, this was weird. The driver already claimed to support UHS mode,
but when in fact it didn't. :-)

Perhaps that change deserves its own fixup patch?

> +                    MMC_CAP_SDIO_IRQ;
> +
> +       /*
> +        * A vqmmc regulator with a 1.8V mode is mandatory to support
> +        * UHS modes.
> +        */
> +       if (!of_property_read_bool(dev->of_node, "no-1-8-v") &&

No, please don't use this binding.

Instead there is already bindings for MMC_CAP_UHS_DDR50 and
MMC_CAP_UHS_SDR50, please use them instead.

> +           !IS_ERR(mmc->supply.vqmmc)) {
> +               mmc->caps |= MMC_CAP_UHS_DDR50 | MMC_CAP_UHS_SDR50;
> +       }
> +
>         /* Set .max_segs to some random number. Feel free to adjust. */
>         mmc->max_segs = 32;
>         mmc->max_blk_size = 512;
> --
> 2.1.4
>

Kind regards
Uffe

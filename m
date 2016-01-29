From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 04/15] mmc: sunxi: Support vqmmc regulator
Date: Fri, 29 Jan 2016 12:40:12 +0100
Message-ID: <CAPDyKFr2PKg83bmewu-iP7HxrUp8QZODBswevpuP3YeX3Mm6tg@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
	<1453354002-28366-5-git-send-email-wens@csie.org>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDF57NG2XIHRBHE7VW2QKGQEBTXLBGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1453354002-28366-5-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 21 January 2016 at 06:26, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> eMMC chips require 2 power supplies, vmmc for internal logic, and vqmmc
> for driving output buffers. vqmmc also controls signaling voltage. Most
> boards we've seen use the same regulator for both, nevertheless the 2
> have different usages, and should be set separately.
>
> This patch adds support for vqmmc regulator supply, including voltage
> switching. The MMC core can use this to try different signaling voltages
> for eMMC.
>
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 0495ae7da6d6..4bec87458317 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -28,6 +28,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/reset.h>
> +#include <linux/regulator/consumer.h>
>
>  #include <linux/of_address.h>
>  #include <linux/of_gpio.h>
> @@ -256,6 +257,9 @@ struct sunxi_mmc_host {
>         struct mmc_request *mrq;
>         struct mmc_request *manual_stop_mrq;
>         int             ferror;
> +
> +       /* vqmmc */
> +       bool            vqmmc_enabled;
>  };
>
>  static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
> @@ -716,6 +720,16 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 if (host->ferror)
>                         return;
>
> +               if (!IS_ERR(mmc->supply.vqmmc)) {
> +                       host->ferror = regulator_enable(mmc->supply.vqmmc);
> +                       if (host->ferror) {
> +                               dev_err(mmc_dev(mmc),
> +                                       "failed to enable vqmmc\n");
> +                               return;
> +                       }
> +                       host->vqmmc_enabled = true;
> +               }
> +
>                 host->ferror = sunxi_mmc_init_host(mmc);
>                 if (host->ferror)
>                         return;
> @@ -727,6 +741,9 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 dev_dbg(mmc_dev(mmc), "power off!\n");
>                 sunxi_mmc_reset_host(host);
>                 mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
> +                       regulator_disable(mmc->supply.vqmmc);
> +               host->vqmmc_enabled = false;
>                 break;
>         }
>
> @@ -758,6 +775,19 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         }
>  }
>
> +static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       /* vqmmc regulator is available */
> +       if (!IS_ERR(mmc->supply.vqmmc))
> +               return mmc_regulator_set_vqmmc(mmc, ios);
> +
> +       /* no vqmmc regulator, assume fixed regulator at 3/3.3V */
> +       if (mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> +               return 0;
> +
> +       return -EINVAL;
> +}
> +
>  static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  {
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> @@ -923,6 +953,7 @@ static struct mmc_host_ops sunxi_mmc_ops = {
>         .get_ro          = mmc_gpio_get_ro,
>         .get_cd          = mmc_gpio_get_cd,
>         .enable_sdio_irq = sunxi_mmc_enable_sdio_irq,
> +       .start_signal_voltage_switch = sunxi_mmc_volt_switch,
>         .hw_reset        = sunxi_mmc_hw_reset,
>         .card_busy       = sunxi_mmc_card_busy,
>  };
> --
> 2.7.0.rc3
>

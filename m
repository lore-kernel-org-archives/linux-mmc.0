From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: pxamci: fix card detect with slot-gpio API
Date: Tue, 29 Sep 2015 12:30:57 +0200
Message-ID: <CAPDyKFqQ7heMVnXpe2pWZ=TzP1GWqJ-UzZb_nBoB_Ph7xZiCyA@mail.gmail.com>
References: <1443296461-20100-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443296461-20100-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Cvek <petr.cvek@tul.cz>
List-Id: linux-mmc@vger.kernel.org

On 26 September 2015 at 21:41, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Move pxamci to mmc slot-gpio API to fix interrupt request.
>
> It fixes the case where the card detection is on a gpio expander, on I2C
> for example on zylonite board. In this case, the card detect netsted
> interrupt is called from a threaded interrupt. The request_irq() fails,
> because a hard irq cannot be a nested interrupt from a threaded
> interrupt (set __setup_irq()).
>
> This was tested on zylonite and mioa701 boards.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Petr Cvek <petr.cvek@tul.cz>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> Since v1: trade threaded interrupt for slot-gpio API
> Since v2: remove gpio_free() calls
> ---
>  drivers/mmc/host/pxamci.c | 66 ++++++++++++++++-------------------------------
>  1 file changed, 22 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 1420f29628c7..8cadd74e8407 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -28,6 +28,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
>  #include <linux/io.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/gpio.h>
> @@ -454,12 +455,8 @@ static int pxamci_get_ro(struct mmc_host *mmc)
>  {
>         struct pxamci_host *host = mmc_priv(mmc);
>
> -       if (host->pdata && gpio_is_valid(host->pdata->gpio_card_ro)) {
> -               if (host->pdata->gpio_card_ro_invert)
> -                       return !gpio_get_value(host->pdata->gpio_card_ro);
> -               else
> -                       return gpio_get_value(host->pdata->gpio_card_ro);
> -       }
> +       if (host->pdata && gpio_is_valid(host->pdata->gpio_card_ro))
> +               return mmc_gpio_get_ro(mmc);
>         if (host->pdata && host->pdata->get_ro)
>                 return !!host->pdata->get_ro(mmc_dev(mmc));
>         /*
> @@ -551,6 +548,7 @@ static void pxamci_enable_sdio_irq(struct mmc_host *host, int enable)
>
>  static const struct mmc_host_ops pxamci_ops = {
>         .request                = pxamci_request,
> +       .get_cd                 = mmc_gpio_get_cd,
>         .get_ro                 = pxamci_get_ro,
>         .set_ios                = pxamci_set_ios,
>         .enable_sdio_irq        = pxamci_enable_sdio_irq,
> @@ -790,37 +788,31 @@ static int pxamci_probe(struct platform_device *pdev)
>                 gpio_power = host->pdata->gpio_power;
>         }
>         if (gpio_is_valid(gpio_power)) {
> -               ret = gpio_request(gpio_power, "mmc card power");
> +               ret = devm_gpio_request(&pdev->dev, gpio_power,
> +                                       "mmc card power");
>                 if (ret) {
> -                       dev_err(&pdev->dev, "Failed requesting gpio_power %d\n", gpio_power);
> +                       dev_err(&pdev->dev, "Failed requesting gpio_power %d\n",
> +                               gpio_power);
>                         goto out;
>                 }
>                 gpio_direction_output(gpio_power,
>                                       host->pdata->gpio_power_invert);
>         }
> -       if (gpio_is_valid(gpio_ro)) {
> -               ret = gpio_request(gpio_ro, "mmc card read only");
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
> -                       goto err_gpio_ro;
> -               }
> -               gpio_direction_input(gpio_ro);
> +       if (gpio_is_valid(gpio_ro))
> +               ret = mmc_gpio_request_ro(mmc, gpio_ro);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
> +               goto out;
> +       } else {
> +               mmc->caps |= host->pdata->gpio_card_ro_invert ?
> +                       MMC_CAP2_RO_ACTIVE_HIGH : 0;
>         }
> -       if (gpio_is_valid(gpio_cd)) {
> -               ret = gpio_request(gpio_cd, "mmc card detect");
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_cd);
> -                       goto err_gpio_cd;
> -               }
> -               gpio_direction_input(gpio_cd);
>
> -               ret = request_irq(gpio_to_irq(gpio_cd), pxamci_detect_irq,
> -                                 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -                                 "mmc card detect", mmc);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "failed to request card detect IRQ\n");
> -                       goto err_request_irq;
> -               }
> +       if (gpio_is_valid(gpio_cd))
> +               ret = mmc_gpio_request_cd(mmc, gpio_cd, 0);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_cd);
> +               goto out;
>         }
>
>         if (host->pdata && host->pdata->init)
> @@ -835,13 +827,7 @@ static int pxamci_probe(struct platform_device *pdev)
>
>         return 0;
>
> -err_request_irq:
> -       gpio_free(gpio_cd);
> -err_gpio_cd:
> -       gpio_free(gpio_ro);
> -err_gpio_ro:
> -       gpio_free(gpio_power);
> - out:
> +out:
>         if (host) {
>                 if (host->dma_chan_rx)
>                         dma_release_channel(host->dma_chan_rx);
> @@ -873,14 +859,6 @@ static int pxamci_remove(struct platform_device *pdev)
>                         gpio_ro = host->pdata->gpio_card_ro;
>                         gpio_power = host->pdata->gpio_power;
>                 }
> -               if (gpio_is_valid(gpio_cd)) {
> -                       free_irq(gpio_to_irq(gpio_cd), mmc);
> -                       gpio_free(gpio_cd);
> -               }
> -               if (gpio_is_valid(gpio_ro))
> -                       gpio_free(gpio_ro);
> -               if (gpio_is_valid(gpio_power))
> -                       gpio_free(gpio_power);
>                 if (host->vcc)
>                         regulator_put(host->vcc);
>
> --
> 2.1.4
>
